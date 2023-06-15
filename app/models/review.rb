class Review < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  
  has_one_attached :image
  
  validates :image, presence: true
  validates :name, presence: true
  validates :detail, presence: true
  validates :maker, presence: true
end
