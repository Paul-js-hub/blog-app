class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :number_of_comments
  after_destroy :decrement_number_of_comments

  def number_of_comments
    post.update(comments_counter: post.comments.all.count)
  end

  def decrement_number_of_comments
    post.update(comments_counter: post.comments_counter - 1)
  end
end
