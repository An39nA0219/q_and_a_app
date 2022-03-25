class AnswersController < ApplicationController
  before_action :require_user_logged_in

  def create
    question = Question.find(id: params[:question_id])
    answer = current_user.answers.build(answer_params)
    question.answers << answer
    flash[:success] = '回答しました'
    users = User.all_other_users_with_questioner(current_user.id, question)
    users.each do |user|
      NotificationMailer.notification_of_getting_answer(user, answer).deliver_later
    end
  end

  def destroy
    answer = Answer.find(id: params[:id])
    question_id = answer.question_id
    if current_user == answer.user
      answer.destroy!
      flash[:success] = '回答を削除しました'
    else
      flash[:danger] = '回答の削除権限がありません'
    end
    redirect_to question_path(question_id)
  end

  private

  def answer_params
    params.permit(:body)
  end
end
