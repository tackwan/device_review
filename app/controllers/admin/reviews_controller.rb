class Admin::ReviewsController < ApplicationController
    before_action :authenticate_admin!

  def index
    @reviews = Review.page(params[:page])
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
      if @review.update(review_params)
        redirect_to admin_review_path(@item.id)
        flash[:notice] = "商品を更新しました"
      else
        flash[:notice] = "必要情報を入力してください"
        render :edit
      end
  end

  private

  def review_params
    params.require(:item).permit(:name,:detail,:maker,:image, :category_id, :page)
  end
end
