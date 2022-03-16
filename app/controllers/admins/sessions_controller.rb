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
      session[:is_for_admin] = true
      flash[:success] = 'ログインしました'
      redirect_to admins_questions_path
    else
      flash.now[:danger] = 'ログインできませんでした'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:is_for_amin] = nil
    flash[:success] = 'ログアウトしました'
    redirect_to admins_login_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
