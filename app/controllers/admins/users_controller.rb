class Admins::UsersController < Admins::BaseController

  def index
    @users = User.all.order(created_at: 'asc').page(params[:page]).per(10)
  end

  def destroy
    user = User.find(params[:id])
    user.image.purge
    user.destroy!
    flash[:success] = 'アカウントを削除しました'
    redirect_to admins_users_path
  end
end
