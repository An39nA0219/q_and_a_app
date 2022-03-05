class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update]

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    if User.create!(user_params)
      # TODO: フラッシュメッセージ OK
      redirect_to login_path
    else
      # TODO: フラッシュメッセージ FAIL
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    unless current_user == @user
      # TODO: フラッシュメッセージ FAIL
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if current_user == @user
      if @user.update!(user_params)
        # TODO: フラッシュメッセージ OK
        render root_path
      else
        # TODO: フラッシュメッセージ FAIL
        render :edit
      end
    else
      # TODO: フラッシュメッセージ FAIL
      render root_path
    end
  end

  private

  def user_params
    params.required(:user).permit(:name)
  end
end
