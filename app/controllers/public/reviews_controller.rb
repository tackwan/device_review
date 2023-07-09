class Public::ReviewsController < ApplicationController
  # before_action :authenticate_user!
  def new
    @form = Review.new
  end

  def create
    @form = Review.new(review_params)
    @form.user_id = current_user.id
    if @form.save
      flash[:notice] = "投稿が成功しました"
      redirect_to review_path(@form)
    else
      flash[:notice] = "必要情報を入力してください"
      render :new
    end
  end

  def index
    @reviews = Review.page(params[:page])
  end

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @review = Review.find(params[:id])
    
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to review_path(@review.id)
      flash[:notice] = "投稿を更新しました"
    else
      flash[:notice] = "必要情報を入力してください"
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:name, :detail, :maker, :category_id, :image, :star, :page)
  end
end
