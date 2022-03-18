class QuestionStatusesController < ApplicationController
  before_action :require_user_logged_in

  def create
    question = Question.find_by(id: params[:id])
    if question
      if current_user == question.user
        question.is_solved = true
        if question.save!
          flash[:success] = '解決済みにしました'
        else
          flash[:danger] = '質問を解決済みにできませんでした'
        end
      else
        flash[:danger] = '質問を解決済みにする権限がありません'
      end
      redirect_to question_path(question.id)
    else
      flash[:danger] = '質問が見つかりませんでした'
      redirect_to questions_path
    end
  end

  def destroy
    question = Question.find_by(id: params[:id])
    if question
      if current_user == question.user
        question.is_solved = false
        if question.save!
          flash[:success] = '質問を未解決にしました'
        else
          flash[:danger] = '質問を未解決にできませんでした'
        end
      else
        flash[:danger] = '質問を未解決にする権限がありません'
      end
      redirect_to question_path(question.id)
    else
      flash[:danger] = '質問が見つかりませんでした'
      redirect_to questions_path
    end
  end
end
