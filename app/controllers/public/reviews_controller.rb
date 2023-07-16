class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :guest_check, only: [:new, :edit]
  def new
    @form = Review.new
  end

  def create
    @form = Review.new(review_params)
    @form.star = params[:score]
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
    @reviews = Review.all.page(params[:page])
    if params[:category_id].present?
      @category = Category.find_by(id: params[:category_id])
      if @category.present?
        @reviews = @category.reviews.page(params[:page])
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
    @star = params[:score]
    if @review.update(review_params.merge(star: @star))
      redirect_to review_path(@review.id)
      flash[:notice] = "投稿を更新しました"
    else
      flash[:notice] = "必要情報を入力してください"
      render :edit
    end
  end

  #カテゴリー絞り込み表示用のアクション
  def mouse
    @reviews = Review.page(params[:page])
    @mouse = Review.joins(:category).where(category: { name: "マウス" })
  end

  def keyboard
    @reviews = Review.all
    @keyboard = Review.where(category:"キーボード")
  end

  def mousepad
    @reviews = Review.all
    @mousepad = Review.where(category:"マウスパッド")
  end

  def headset
    @reviews = Review.all
    @headset = Review.where(category:"ヘッドセット")
  end

  def monitor
    @reviews = Review.all
    @monitor = Review.where(maker:"モニター")
  end


  private

  def review_params
    params.require(:review).permit(:name, :detail, :maker, :category_id, :image, :star, :page)
  end
end
