class Api::V1::PostsController < ApplicationController
  before_action :find_user
  def index
    @posts = @user.posts
    render json: @posts, status: 200
  end

  def show
    @post = @user.posts.find(params[:id])
    render json: @post
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
