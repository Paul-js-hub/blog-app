require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'displays a list of all users' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'has a text in the response body' do
      get '/users'
      expect(response.body).to include('This page displays a list of all users')
    end

    it 'has a text in the response body' do
      get '/users'
      expect(response.status).to eq 200
    end
  end

  describe 'GET /users/1' do
    it 'displays a specific user' do
      get '/users/1'
      expect(response).to render_template(:show)
    end

    it 'has a text in the response body' do
      get '/users/1'
      expect(response.body).to include('This page displays a specific user')
    end

    it 'has the correct status response' do
      get '/users/1'
      expect(response.status).to eq 200
    end
  end
end
