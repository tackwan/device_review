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
    @reviews = Review.page(params[:page])
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
    @reviews = Review.all
    @mouse = Review.where(maker:"マウス")
  end

  def keyboard
    @reviews = Review.all
    @mouse = Review.where(maker:"キーボード")
  end

  def mousepad
    @reviews = Review.all
    @mouse = Review.where(maker:"マウスパッド")
  end

  def headset
    @reviews = Review.all
    @mouse = Review.where(maker:"ヘッドセット")
  end

  def monitor
    @reviews = Review.all
    @mouse = Review.where(maker:"モニター")
  end


  private

  def review_params
    params.require(:review).permit(:name, :detail, :maker, :category_id, :image, :star, :page)
  end
end
