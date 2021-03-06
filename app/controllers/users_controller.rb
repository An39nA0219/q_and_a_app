class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update]

  def index
    @users = User.all.order(created_at: 'asc').page(params[:page]).per(10)
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.save!
    user.image.attach(user_params[:image]) if user_params[:image]
    flash[:success] = 'サインアップが完了しました'
    redirect_to questions_path
  end

  def edit
    user = User.find(params[:id])
    if current_user == user
      @user = user
    else
      flash[:danger] = 'アカウントの編集権限がありません'
      redirect_to questions_path
    end
  end

  def update
    user = User.find(params[:id])
    if current_user == user
      user.update!(user_edit_params)
      user.image.attach(user_params[:image]) if user_params[:image]
      flash[:success] = 'アカウントを編集しました'
      redirect_to questions_path
    else
      flash[:danger] = 'アカウントの編集権限がありません'
      redirect_to questions_path
    end
  end

  private

  def user_params
    params.required(:user).permit(:name, :email, :password, :image)
  end

  def user_edit_params
    params.required(:user).permit(:name)
  end
end
