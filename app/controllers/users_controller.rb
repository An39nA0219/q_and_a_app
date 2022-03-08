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
      flash[:success] = 'アカウントを作成しました'
      redirect_to login_path
    else
      flash.now[:danger] = 'アカウントを作成できませんでした'
      render :new
    end
  end

  def edit
    user = User.find_by(id: params[:id])
    if user
      if current_user == user
        @user = user
      else
        flash[:danger] = 'アカウントの編集権限がありません'
        redirect_to root_path
      end
    else
        flash[:danger] = 'アカウントが見つかりませんでした'
        redirect_to root_path
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user
      if current_user == user
        if user.update!(user_params)
          flash[:success] = 'アカウントを編集しました'
          render root_path
        else
          flash.now[:danger] = 'アカウントの編集ができませんでした'
          render :edit
        end
      else
        flash[:danger] = 'アカウントの編集権限がありません'
        redirect_to root_path
      end
    else
      flash[:danger] = 'アカウントが見つかりませんでした'
      redirect_to root_path
    end
  end

  private

  def user_params
    params.required(:user).permit(:name)
  end
end
