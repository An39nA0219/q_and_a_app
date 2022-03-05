class QuestionsController < ApplicationController
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
    else
      render :new
    end
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def update
    @question = Question.find_by(id: params[:id])
    if @question.update!(question_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find_by(id: params[:id])
    @question.destroy!
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
