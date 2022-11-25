class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :number_of_likes

  def number_of_likes
    post.update(likes_counter: post.likes.all.count)
  end
end
