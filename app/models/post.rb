class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user, class_name: 'User'
  after_save :number_of_posts

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  def number_of_posts
    user.update(posts_counter: user.posts.all.count)
  end

  def five_most_comments
    comments.order(created_at: :desc).limit(5)
  end
end
