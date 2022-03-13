class Admins::AnswersController < ApplicationController
  before_action :require_admin_logged_in

  def destroy
    answer = Answer.find_by(id: params[:id])
    if answer
      question_id = answer.question_id
      if answer.destroy!
        flash[:success] = '回答を削除しました'
      else
        flash[:danger] = '回答を削除できませんでした'
      end
      redirect_to admins_question_path(question_id)
    else
      flash[:danger] = '回答が見つかりませんでした'
      redirect_to admins_questions_path
    end
  end
end