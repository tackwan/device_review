class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :email, uniqueness: true
  def active_for_authentication?
    super && (is_deleted == false)
  end
end