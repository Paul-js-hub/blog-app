require 'rails_helper'

RSpec.describe 'Users Index page', type: :feature do
  describe 'User Index Page' do
    before(:each) do 
        @user2 = User.create(name: 'David', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher From Country', posts_counter: 2)
        @user3 = User.create(name: 'Stacy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher From Country', posts_counter: 1)
        visit root_path
    end

    scenario 'I can see the username of all other users' do
        expect(page).to have_content('David')
        expect(page).to have_content('Stacy')
    end

    scenario 'I can see the profile picture for each user' do
        all('img').each do |i|
            expect(i[:src]).to eq('https://unsplash.com/photos/F_-0BxGuVvo')
        end
    end

    scenario 'I can see the number of posts each user has written' do
        expect(page).to have_content(2)
        expect(page).to have_content(1)
    end

    scenario 'When I click on a user, I am redirected to that user\'s show page.' do
        visit users_path
        find_link("#{@user2.name}").click
        expect(current_path).to eq user_path(@user2.id)
    end
  end
end