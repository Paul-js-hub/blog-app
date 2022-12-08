class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments.includes(:user) # query should be @post.comments.all if no eager loading detected
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

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_to user_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
