require 'rails_helper'

RSpec.describe Post, type: :model do
  user1 = User.create(name: 'Paul', photo: 'photo', bio: 'bio', posts_counter: 0)
  subject { Post.new(title: 'title1', text: 'text1', user: user1) }
  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'number of posts for a user' do
    expect(user1.posts_counter).to eql 1
  end

  it 'name should be present' do
    subject.comments_counter = 0
    Comment.create(user: user1, post: subject, text: 'comment1')
    Comment.create(user: user1, post: subject, text: 'comment2')
    Comment.create(user: user1, post: subject, text: 'comment3')
    Comment.create(user: user1, post: subject, text: 'comment4')
    Comment.create(user: user1, post: subject, text: 'comment5')
    expect(subject.five_most_comments.count).to eql 5
  end
end
