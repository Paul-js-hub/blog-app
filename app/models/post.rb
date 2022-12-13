class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user, class_name: 'User'
  after_save :number_of_posts
  after_destroy :post_counter_decrement

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  def number_of_posts
    user.update(posts_counter: user.posts.all.count)
  end

  def post_counter_decrement
    user.update(posts_counter: user.posts_counter - 1)
  end

  def five_most_comments
    comments.includes(:user).order(created_at: :desc).limit(5)
  end
end
