class QuestionsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find_by(id: params[:id])
    @answer = Answer.new
    @answers = Answer.where(question_id: params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    current_user.questions.build(question_params)
    if current_user.save!
      redirect_to questions_path
      # TODO: フラッシュメッセージ OK
    else
      render :new
      # TODO: フラッシュメッセージ FAIL
    end
  end

  def edit
    @question = Question.find_by(id: params[:id])
    unless current_user == @question.user
      redirect_to questions_path
      # TODO: フラッシュメッセージ FAIL
    end
  end

  def update
    @question = Question.find_by(id: params[:id])
    if current_user == @question.user
      if @question.update!(question_params)
        redirect_to questions_path
        # TODO: フラッシュメッセージ OK
      else
        render :edit
        # TODO: フラッシュメッセージ FAIL
      end
    else
      redirect_to questions_path
      # TODO: フラッシュメッセージ FAIL
    end
  end

  def destroy
    @question = Question.find_by(id: params[:id])
    if current_user == @question.user
      @question.destroy!
      # TODO: フラッシュメッセージ OK
    else
      # TODO: フラッシュメッセージ FAIL
    end
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
