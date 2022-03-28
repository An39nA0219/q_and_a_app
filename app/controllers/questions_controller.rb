class QuestionsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]

  def index
    questions = if params[:words].present?
                  Question.title_like_search(params[:words])
                else
                  Question.all.order(created_at: :desc)
                end
    @questions = questions.page(params[:page]).per(10)
  end

  def solved
    questions = if params[:words].present?
                  Question.where(solved: true).title_like_search(params[:words])
                else
                  Question.where(solved: true).order(created_at: :desc)
                end
    @questions = questions.page(params[:page]).per(10)
  end

  def unsolved
    questions = if params[:words].present?
                  Question.where(solved: false).title_like_search(params[:words])
                else
                  Question.where(solved: false).order(created_at: :desc)
                end
    @questions = questions.page(params[:page]).per(10)
  end

  def show
    question = Question.find(params[:id])
    @question = question
    @answer = Answer.new
    @answers = Answer.where(question_id: params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    question = current_user.questions.build(question_params)
    current_user.save!
    flash[:success] = '質問を作成しました'
    users = User.all_others(current_user.id)
    users.each do |user|
      NotificationMailer.notification_of_getting_question(user, question).deliver_later
    end
    redirect_to question_path(question.id)
  end

  def edit
    question = Question.find(params[:id])
    if current_user == question.user
      @question = question
    else
      flash[:danger] = '質問の編集権限がありません'
      redirect_to question_path(question.id)
    end
  end

  def update
    question = Question.find(params[:id])
    if current_user == question.user
      question.update!(question_params)
      flash[:success] = '質問を更新しました'
      redirect_to question_path(question.id)
    else
      flash[:danger] = '質問の編集権限がありません'
      redirect_to question_path(question.id)
    end
  end

  def destroy
    question = Question.find(params[:id])
    if current_user == question.user
      question.answers.destroy_all && question.destroy!
      flash[:success] = '質問を削除しました'
      redirect_to questions_path
    else
      flash[:danger] = '質問の削除権限がありません'
      redirect_to question_path(question.id)
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
