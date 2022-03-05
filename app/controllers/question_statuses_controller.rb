class QuestionStatusesController < ApplicationController
  def create
    question = Question.find_by(id: params[:id])
    question.is_solved = true
    if question.save!
      redirect_to question_path(question.id)
    end
  end

  def destroy
    question = Question.find_by(id: params[:id])
    question.is_solved = false
    if question.save!
      redirect_to question_path(question.id)
    end
  end
end
