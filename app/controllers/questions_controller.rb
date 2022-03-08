class QuestionsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @questions = Question.all
  end

  def show
    question = Question.find_by(id: params[:id])
    if question
      @question = question
      @answer = Answer.new
      @answers = Answer.where(question_id: params[:id])
    else
      flash[:danger] = '質問が見つかりませんでした'
      redirect_to questions_path
    end
  end

  def new
    @question = Question.new
  end

  def create
    question = current_user.questions.build(question_params)
    if current_user.save!
      flash[:success] = '質問を投稿しました'
      redirect_to question_path(question.id)
    else
      flash.now[:danger] = '質問を投稿できませんでした'
      render :new
    end
  end

  def edit
    question = Question.find_by(id: params[:id])
    if question
      if current_user == @question.user
        @question = question
      else
        flash[:danger] = '質問の編集権限がありません'
        redirect_to question_path(question.id)
      end
    else
      flash[:danger] = '質問が見つかりませんでした'
      redirect_to questions_path
    end
  end

  def update
    question = Question.find_by(id: params[:id])
    if question
      if current_user == @question.user
        if question.update!(question_params)
          flash[:success] = '質問を編集しました'
          redirect_to question_path(question.id)
        else
          flash.now[:danger] = '質問を編集できませんでした'
          render :edit
        end
      else
        flash[:danger] = '質問の編集権限がありません'
        redirect_to question_path(question.id)
      end
    else
      flash[:danger] = '質問が見つかりませんでした'
      redirect_to questions_path
    end
  end

  def destroy
    question = Question.find_by(id: params[:id])
    if question
      if current_user == question.user
        if question.destroy!
          flash[:success] = '質問を削除しました'
          redirect_to questions_path
        else
          flash[:danger] = '質問を削除できませんでした'
          redirect_to question_path(question.id)
        end
      else
        flash[:danger] = '質問の削除権限がありません'
        redirect_to question_path(question.id)
      end
    else
      flash[:danger] = '質問が見つかりませんでした'
      redirect_to questions_path
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
