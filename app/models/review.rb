class Review < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  has_one_attached :image

  def get_image(width, height)
  image.variant(resize_to_limit: [width, height]).processed
  end

  validates :image, presence: true
  validates :name, presence: true
  validates :detail, presence: true
  validates :maker, presence: true
  
  # 最新投稿
  scope :recent_reviews, -> { order(created_at: :desc).limit(4) }

# 検索用
  def self.looks(search, word)
    if search == "perfect_match"
      @review = Review.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @review = Review.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @review = Review.where("name LIKE?", "%#{word}")
    elsif search == "partial_match"
      @review = Review.where("name LIKE?", "%#{word}%")
    else
      @review = Review.all
    end
  end
end
