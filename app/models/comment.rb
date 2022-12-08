class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :number_of_comments

  def number_of_comments
    post.update(comments_counter: post.comments.all.count)
  end
end
