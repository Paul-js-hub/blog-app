require 'rails_helper'

RSpec.describe 'Posts Show  page', type: :feature do
  describe 'post index Page' do
    before(:each) do
      @user2 = User.create(name: 'David', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                           bio: 'Teacher From Country', posts_counter: 5)
      visit root_path

      @post1 = Post.create(user: @user2, title: 'My First Post', text: 'This is my first post', comments_counter: 1,
                           likes_counter: 2)
      @post2 = Post.create(user: @user2, title: 'My second Post', text: 'This is my first post', comments_counter: 2,
                           likes_counter: 3)
      @post3 = Post.create(user: @user2, title: 'My third Post', text: 'This is my first post', comments_counter: 3,
                           likes_counter: 4)
      @post4 = Post.create(user: @user2, title: 'My fourth Post', text: 'This is my first post', comments_counter: 4,
                           likes_counter: 5)
      visit user_path(@user2.id)

      @comment1 = Comment.create(post: @post1, user: @user2, text: 'Hi Tom!')
      @comment2 = Comment.create(post: @post2, user: @user2, text: 'Hi Tom!')

      visit user_post_path(@user2, @post1)
    end

    scenario 'I can see a post\'s title' do
      expect(page).to have_content('post')
    end

    scenario 'I can see who wrote the post' do
      expect(page).to have_content('David')
    end

    scenario 'I can see how many comments it has' do
      post = Post.first
      expect(page.body).to have_content(post.comments_counter)
    end

    scenario 'I can see how many likes it has' do
      post = Post.first
      expect(page.body).to have_content(post.likes_counter)
    end

    scenario 'I can see the post body' do
      expect(page).to have_content('This is my first post')
    end

    scenario 'I can see the username of each commentor.' do
      expect(page).to have_content('David')
    end

    scenario 'I can see the comment each commentor left.' do
      expect(page).to have_content('Hi Tom!')
    end
  end
end
