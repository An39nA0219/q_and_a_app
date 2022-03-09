class Admins::QuestionsController < ApplicationController
  before_action :require_admin_logged_in

  def index
    @questions = Question.all
  end

  def solved
    @questions = Question.where(is_solved: true)
  end

  def unsolved
    @questions = Question.where(is_solved: false)
  end

  def show
    question = Question.find_by(id: params[:id])
    if question
      @question = question
      @answers = Answer.where(question_id: params[:id])
    else
      flash[:danger] = '質問が見つかりませんでした'
      redirect_to admins_questions_path
    end
  end

  def destroy
    question = Question.find_by(id: params[:id])
    if question
      if question.destroy!
        flash[:success] = '質問を削除しました'
        redirect_to admins_questions_path
      else
        flash[:danger] = '質問を削除できませんでした'
        redirect_to admins_question_path(question.id)
      end
    else
      flash[:danger] = '質問が見つかりませんでした'
      redirect_to admins_questions_path
    end
  end
end
