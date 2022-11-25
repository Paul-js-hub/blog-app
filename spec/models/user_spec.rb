require 'rails_helper'

RSpec.describe Spec, type: :model do
  subject { User.new(name: 'Paul', photo: 'photo', bio: 'bio', posts_counter: 0) }
  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts counter should be valid' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end

  it 'returns the three recent posts for a user' do
    subject.posts_counter = 0
    Post.create(user: subject, title: 'title1', text: 'text1')
    Post.create(user: subject, title: 'title2', text: 'text2')
    Post.create(user: subject, title: 'title3', text: 'title3')
    expect(subject.three_recent_posts.count).to eql 3
  end
end
