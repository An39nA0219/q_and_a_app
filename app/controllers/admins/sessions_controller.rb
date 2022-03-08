class Admins::SessionsController < ApplicationController
  before_action :require_admin_logged_in, only: [:destroy]

  def new
  end

  def create
    email = session_params[:email].downcase
    password = session_params[:password]
    user = User.find_by(email: email)
    if user && user&.authenticate(password) && user.is_admin
      session[:user_id] = user.id
      flash[:success] = 'ログインしました'
      redirect_to root_path
    else
      flash.now[:danger] = 'ログインできませんでした'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました'
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
