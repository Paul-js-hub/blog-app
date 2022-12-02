class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user: current_user)
    respond_to do |format|
      if @like.save
        format.html { redirect_to user_post_path(@post.user.id, @post.id) }
      end
    end
  end
end
