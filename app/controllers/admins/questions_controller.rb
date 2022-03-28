class Admins::QuestionsController < Admins::BaseController

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
    @answers = Answer.where(question_id: params[:id])
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy!
    flash[:success] = '質問を削除しました'
    redirect_to admins_questions_path
  end
end
