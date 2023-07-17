class Public::UsersController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit,:update]

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.all.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新に成功しました"
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  def check
    @user = current_user
  end
# 退会処理
  def withdrawal
    @user = current_user
    #is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :page, :profile_image)
  end
  # ゲストログインの判別
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(user.id)
    end
  end
end

