class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:index,:show,:edit,:update]
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "更新に成功しました"
      redirect_to admin_user_path(user.id)
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
