class User < ApplicationRecord
  has_secure_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :posts, foreign_key: :user_id, dependent: :destroy
  has_many :comments, foreign_key: :user_id, dependent: :destroy
  has_many :likes, foreign_key: :user_id, dependent: :destroy

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  def three_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
