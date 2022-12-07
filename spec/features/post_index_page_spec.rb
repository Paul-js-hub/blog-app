require 'rails_helper'

RSpec.describe 'Post Index  page', type: :feature do
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
      visit user_posts_path(@user2.id)
    end

    scenario 'I can see the user\'s profile picture.' do
      expect(page).to have_css('div.user-icon')
    end

    scenario 'I can see the user\'s username' do
      expect(page).to have_content('David')
    end

    scenario 'I can see the number of posts the user has written' do
        visit user_posts_path(@user2.id)
        expect(page).to have_content(4)
    end

    scenario 'I can see a post\'s title' do
      expect(page).to have_content('Post')
      expect(page).to have_content('My First Post')
    end

    scenario 'I can see some of the post\'s body' do
      expect(page).to have_content('This is my first post')
    end

    scenario 'I can see the first comments on a post' do
      expect(page).to have_content('Hi Tom!')
    end

    scenario 'I can see how many comments a post has.' do
      post = Post.first
      expect(page.body).to have_content(post.comments_counter)
    end

    scenario 'I can see how many likes a post has' do
      post = Post.first
      expect(page.body).to have_content(post.likes_counter)
    end

    scenario 'I can see a section for pagination if there are more posts than fit on the view.' do
      expect(find_link('Pagination')).to be_visible
    end

    scenario 'When I click on a post, it redirects me to that post\'s show page' do
      find_link('My First Post').click
      expect(page).to have_current_path user_post_path(@post1.user_id, @post1)
    end
  end
end
