class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_path(current_user, @post.id), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: user_post_path(current_user, @post.id) }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
