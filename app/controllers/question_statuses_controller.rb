class QuestionStatusesController < ApplicationController
  before_action :require_user_logged_in

  def create
    question = Question.find(params[:id])
    if current_user == question.user
      question.solved = true
      question.save!
    else
      flash[:danger] = '質問を解決済みにする権限がありません'
    end
    redirect_to question_path(question.id)
  end

  def destroy
    question = Question.find(params[:id])
    if current_user == question.user
      question.solved = false
      question.save!
      flash[:success] = '質問を未解決にしました'
    else
      flash[:danger] = '質問を未解決にする権限がありません'
    end
    redirect_to question_path(question.id)
  end
end
