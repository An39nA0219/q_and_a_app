class SessionsController < ApplicationController
  def new
  end

  def create
    email = session_params[:email].downcase
    password = session_params[:password]
    user = User.find_by(email: email)
    if user && user&.authenticate(password)
      session[:user_id] = user.id
      redirect_to questions_path
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
