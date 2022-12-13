class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(text: comment_params[:text], user: current_user)

    respond_to do |format|
      format.html do
        redirect_to user_post_path(@post.user.id, @post.id) if comment.save
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(@post.user.id, @post.id)
  end

  private

  def comment_params
    params.require(:data).permit(:text)
  end
end
