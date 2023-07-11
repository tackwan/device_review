class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @range = params[:range]
    if @range == "ユーザー"
      @users = User.looks(params[:search], params[:word])
      render :search_result
    else
      @reviews = Review.looks(params[:search], params[:word])
      render :search_result
    end
  end
end
