# frozen_string_literal: true

require 'rails_helper'
require 'sessions_controller'

RSpec.describe PostsController, type: :controller do
  before do
    user = User.create!(email: 'test@abc.com', password: 'password')
    login(user)
  end

  describe 'GET /new ' do
    it 'responds with 200' do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /' do
    it 'responds with 200' do
      post :create, params: { post: {
        message: 'Hello, world!',
        users_id: session[:user_id],
        post_type: 'public',
        recipient_id: session[:user_id]
      } }
      expect(response).to redirect_to('/posts')
    end

    it 'creates a post' do
      post :create, params: { post: {
        message: 'Hello, world!',
        users_id: session[:user_id],
        post_type: 'public',
        recipient_id: session[:user_id]
      } }
      expect(Post.find_by(message: 'Hello, world!')).to be_a Post
    end
  end

  describe 'GET /' do
    it 'responds with 200' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
