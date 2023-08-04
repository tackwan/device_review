class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_check
  before_action :ensure_user, only: [:destroy]
  
  def create
    review = Review.find(params[:review_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.review_id = review.id
    comment.save
    redirect_to review_path(review)
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to review_path(params[:review_id])
  end 
  
  private
  
  #他ユーザーによる編集・削除を防ぐ
  def ensure_user
    @comments = current_user.comments
    @comment = @comments.find_by(id: params[:id])
    redirect_to new_review_path unless @comment
  end
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
end