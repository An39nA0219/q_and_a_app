class SessionsController < ApplicationController
  before_action :require_user_logged_in, only: [:destroy]

  def new
  end

  def create
    email = session_params[:email].downcase
    password = session_params[:password]
    user = User.find_by(email: email)
    if user && user&.authenticate(password)
      session[:user_id] = user.id
      redirect_to root_path
      # TODO: フラッシュメッセージ OK
    else
      render :new
      # TODO: フラッシュメッセージ FAIL
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
    # TODO: フラッシュメッセージ OK
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
