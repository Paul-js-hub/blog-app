require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/500/posts' do
    it 'displays a list of all posts for a specific user' do
      get '/users/500/posts'
      expect(response).to render_template(:index)
    end

    it 'has a text in the response body' do
      get '/users/500/posts'
      expect(response.body).to include('This page displays a list of all posts for a specific user')
    end

    it 'has the correct status response' do
      get '/users/500/posts'
      expect(response.status).to eq 200
    end
  end

  describe 'GET /users/500/posts/1' do
    it 'displays a specific post belonging to a specific user' do
      get '/users/500/posts/1'
      expect(response).to render_template(:show)
    end

    it 'has a text in the response body' do
      get '/users/500/posts/1'
      expect(response.body).to include('This page displays a specific post belonging to a specific user')
    end

    it 'has the correct status response' do
      get '/users/500/posts/1'
      expect(response.status).to eq 200
    end
  end
end
