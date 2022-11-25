require 'rails_helper'

RSpec.describe Like, type: :model do
  user1 = User.create(name: "Paul", photo: "photo", bio: "bio", posts_counter: 0)
  post1 = Post.create(title: "title1", text: "text1", user: user1)
  Like.create(user: user1, post: post1)

  it '#counter' do
    expect(post1.likes_counter).to eql 1
    Like.create(user: user1, post: post1)
    expect(post1.likes_counter).to eql 2
  end
end
