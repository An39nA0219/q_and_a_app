class Admins::AnswersController < ApplicationController
  before_action :require_admin_logged_in

  def destroy
    answer = Answer.find(id: params[:id])
    question_id = answer.question_id
    answer.destroy!
    flash[:success] = '回答を削除しました'
    redirect_to admins_question_path(question_id)
  end
end
