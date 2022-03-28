class Admins::AnswersController < Admins::BaseController

  def destroy
    answer = Answer.find(params[:id])
    question_id = answer.question_id
    answer.destroy!
    flash[:success] = '回答を削除しました'
    redirect_to admins_question_path(question_id)
  end
end
