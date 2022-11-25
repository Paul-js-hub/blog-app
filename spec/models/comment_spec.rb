require 'rails_helper'

RSpec.describe Comment, type: :model do
  user1 = User.create(name: "Paul", photo: "photo", bio: "bio", posts_counter: 0)
  post1 = Post.create(title: "title1", text: "text1", user: user1)
  subject { Comment.new(text: "Lovely", user: user1, post: post1) }
  before { subject.save }

  it "number of comments" do
    expect(post1.comments_counter).to eql 1
  end
end
