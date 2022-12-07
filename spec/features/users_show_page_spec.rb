require 'rails_helper'

RSpec.describe 'Users Show  page', type: :feature do
  describe 'User show Page' do
    before(:each) do
      @user2 = User.create(name: 'David', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                           bio: 'Teacher From Country', posts_counter: 5)
      @user3 = User.create(name: 'Stacy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                           bio: 'Teacher From Country', posts_counter: 6)
      @user4 = User.create(name: 'Malcom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                           bio: 'Teacher From Country', posts_counter: 7)
      @user5 = User.create(name: 'Grace', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                           bio: 'Teacher From Country', posts_counter: 8)
      @user6 = User.create(name: 'Jenny', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                           bio: 'Teacher From Country', posts_counter: 9)
      visit root_path

      @post1 = Post.create(user: @user2, title: 'My First Post', text: 'This is my first post', comments_counter: 1,
                           likes_counter: 2)
      @post2 = Post.create(user: @user3, title: 'My Second Post', text: 'This is my first post', comments_counter: 2,
                           likes_counter: 3)
      @post3 = Post.create(user: @user4, title: 'My Third Post', text: 'This is my first post', comments_counter: 3,
                           likes_counter: 4)
      @post4 = Post.create(user: @user5, title: 'My Fourth Post', text: 'This is my first post', comments_counter: 4,
                           likes_counter: 5)
      @post5 = Post.create(user: @user6, title: 'My Fifth Post', text: 'This is my first post', comments_counter: 4,
                           likes_counter: 6)

      visit user_path(@user2.id)
    end

    scenario 'I can see the user\'s profile picture.' do
      expect(page).to have_css('div.user-icon')
    end

    scenario 'I can see the username of all other users' do
      expect(page).to have_content('David')
    end

    scenario 'I can see the number of posts the user has written' do
      expect(page.body).to have_content(5)
    end

    scenario 'I can see the user\'s bio' do
      expect(page).to have_content('Bio')
      expect(page).to have_content('Teacher From Country')
    end

    scenario 'I can see the user\'s first 3 posts' do
      @user2.three_recent_posts.each do |post|
        expect(page).to have_content(post.id)
        expect(page).to have_content(post.text)
      end
    end

    scenario 'I can see a button that lets me view all of a user\'s posts' do
      expect(find_link('See all Posts')).to be_visible
      expect(page).to have_link('See all Posts')
    end

    scenario 'When I click a user\'s post, it redirects me to that post\'s show page.' do
      click_on 'See all Posts'
      expect(page).to have_current_path(user_posts_path(@user2.id))
    end

    scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
      click_on 'See all Posts'
      expect(page).to have_current_path(user_posts_path(@user2.id))
    end
  end
end
