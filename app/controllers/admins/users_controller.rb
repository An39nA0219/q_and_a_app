class Admins::UsersController < ApplicationController
  before_action :require_admin_logged_in

  def index
    @users = User.all.order(created_at: 'asc').page(params[:page]).per(10)
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user
      if !user.is_admin
        if user.answers.destroy_all && user.questions.destroy_all && user.destroy!
          flash[:success] = 'アカウントを削除しました'
          redirect_to admins_users_path
        else
          flash[:danger] = 'アカウントを削除できませんでした'
          redirect_to admins_user_path(user.id)
        end
      else
        flash[:danger] = '管理者アカウントは削除できません'
        redirect_to admins_users_path
      end
    else
      flash[:danger] = 'アカウントが見つかりませんでした'
      redirect_to admins_users_path
    end
  end
end
