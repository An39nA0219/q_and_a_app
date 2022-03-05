class QuestionStatusesController < ApplicationController
  before_action :require_user_logged_in

  def create
    question = Question.find_by(id: params[:id])
    if current_user == question.user
      question.is_solved = true
      if question.save!
        # TODO: フラッシュメッセージ OK
      else
        # TODO: フラッシュメッセージ FAIL
      end
    else
      # TODO: フラッシュメッセージ FAIL
    end
    redirect_to question_path(question.id)
  end

  def destroy
    question = Question.find_by(id: params[:id])
    if current_user == question.user
      question.is_solved = false
      if question.save!
        # TODO: フラッシュメッセージ OK
      else
        # TODO: フラッシュメッセージ FAIL
      end
    else
      # TODO: フラッシュメッセージ FAIL
    end
    redirect_to question_path(question.id)
  end
end
