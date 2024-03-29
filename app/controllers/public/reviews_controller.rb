class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :guest_check, only: [ :edit, :update, :destroy]
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def new
    @form = Review.new
  end

  def create
    @form = Review.new(review_params)
    #@form.star = params[:score]
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
      redirect_to review_path(@review.id)
      flash[:notice] = "投稿を更新しました"
    else
      flash[:notice] = "必要情報を入力してください"
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end

  private
  
  #他ユーザーによる編集・削除を防ぐ
  def ensure_user
    @reviews = current_user.reviews
    @review = @reviews.find_by(id: params[:id])
    redirect_to new_review_path unless @review
  end

  def review_params
    params.require(:review).permit(:name, :detail, :maker, :category_id, :image, :star, :page)
  end
end
