class AnswersController < ApplicationController
  def create
    question = Question.find_by(id: params[:question_id])
    if question
      answer = current_user.answers.build(answer_params)
      question.answers << answer
      redirect_to question_path(question.id)
    end
  end

  def update
    answer = Answer.find_by(id: params[:id])
    if answer.update!(answer_params)
      redirect_to question_path(answer.question_id)
    end
  end

  def destroy
    answer = Answer.find_by(id: params[:id])
    question_id = answer.question_id
    if answer.destroy!
      redirect_to question_path(question_id)
    end
  end

  private

  def answer_params
    params.permit(:content)
  end
end
