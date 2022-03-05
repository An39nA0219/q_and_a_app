class AnswersController < ApplicationController
  before_action :require_user_logged_in

  def create
    question = Question.find_by(id: params[:question_id])
    if question
      answer = current_user.answers.build(answer_params)
      question.answers << answer
      # TODO: フラッシュメッセージ OK
    else
      # TODO: フラッシュメッセージ OK
    end
    redirect_to question_path(question.id)
  end

  def update
    answer = Answer.find_by(id: params[:id])
    if current_user == answer.answerer
      if answer.update!(answer_params)
        # TODO: フラッシュメッセージ OK
      else
        # TODO: フラッシュメッセージ FAIL
      end
    else
      # TODO: フラッシュメッセージ FAIL
    end
    redirect_to question_path(answer.question_id)
  end

  def destroy
    answer = Answer.find_by(id: params[:id])
    question_id = answer.question_id
    if current_user == answer.answerer
      if answer.destroy!
        # TODO: フラッシュメッセージ OK
      else
        # TODO: フラッシュメッセージ FAIL
      end
    else
      # TODO: フラッシュメッセージ FAIL
    end
    redirect_to question_path(question_id)
  end

  private

  def answer_params
    params.permit(:content)
  end
end
