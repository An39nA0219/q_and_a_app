class Admins::QuestionsController < ApplicationController
  before_action :require_admin_logged_in

  def index
    questions = if !!params[:words]
                  Question.where('title LIKE ?', "%#{params[:words]}%").order(created_at: 'desc')
                else
                  Question.all.order(created_at: 'desc')
                end
    @questions = questions.page(params[:page]).per(10)
  end

  def solved
    questions = if !!params[:words]
                  Question.where(is_solved: true).where('title LIKE ?', "%#{params[:words]}%").order(created_at: 'desc')
                else
                  Question.where(is_solved: true).order(created_at: 'desc')
                end
    @questions = questions.page(params[:page]).per(10)
  end

  def unsolved
    questions = if !!params[:words]
                  Question.where(is_solved: false).where('title LIKE ?', "%#{params[:words]}%").order(created_at: 'desc')
                else
                  Question.where(is_solved: false).order(created_at: 'desc')
                end
    @questions = questions.page(params[:page]).per(10)
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
      if question.answers.destroy_all && question.destroy!
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
