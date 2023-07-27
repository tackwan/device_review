class Admin::ReviewsController < ApplicationController
    before_action :authenticate_admin!

  def index
    @reviews = Review.all.page(params[:page]).per(5)
    if params[:category_id].present?
      @category = Category.find_by(id: params[:category_id])
      if @category.present?
        @reviews = @category.reviews.page(params[:page]).per(5)
      end
    end
  end

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
    @user = @review.user
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
      if @review.update(review_params)
        redirect_to admin_review_path(@review.id)
        flash[:notice] = "更新に成功しました"
      else
        flash[:notice] = "必要情報を入力してください"
        render :edit
      end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_root_path
  end

  private

  def review_params
    params.require(:review).permit(:name, :detail, :maker, :category_id, :image, :star, :page)
  end
end
