class AnswersController < ApplicationController
  before_action :require_user_logged_in

  def create
    question = Question.find_by(id: params[:question_id])
    if question
      answer = current_user.answers.build(answer_params)
      question.answers << answer
      flash[:success] = '回答しました'
      users = User.all_other_answerers_with_questioner(current_user.id, question)
      users.each do |user|
        NotificationMailer.notification_of_getting_answer(user, answer).deliver_later
      end
      redirect_to question_path(question.id)
    else
      flash[:danger] = '質問が見つかりませんでした'
      redirect_to root_path
    end
  end

  def destroy
    answer = Answer.find_by(id: params[:id])
    if answer
      question_id = answer.question_id
      if current_user == answer.answerer
        if answer.destroy!
          flash[:success] = '回答を削除しました'
        else
          flash[:danger] = '回答を削除できませんでした'
        end
      else
        flash[:danger] = '回答の削除権限がありません'
      end
      redirect_to question_path(question_id)
    else
      flash[:danger] = '回答が見つかりませんでした'
      redirect_to root_path
    end
  end

  private

  def answer_params
    params.permit(:content)
  end
end
