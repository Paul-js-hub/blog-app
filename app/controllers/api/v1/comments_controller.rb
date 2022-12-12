class Api::V1::CommentsController < Api::V1::ApplicationController
  def index
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comments = @post.comments.all
    render json: @comments, status: 200
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(text: comment_params[:text])
    if @comment.save
      render json: @comment, status: 201
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
