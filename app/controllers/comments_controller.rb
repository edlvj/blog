class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    authorize @comment

    if @comment.save 
      flash[:notice] = "Comment created"
      redirect_to @post
    end  
  end

  def destroy 
    @comment = @post.comments.find(params[:id])
    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment deleted"
      redirect_to @post
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
