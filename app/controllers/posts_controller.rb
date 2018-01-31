class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
    @posts = @posts.where(user_id: params[:user_id]) if params[:user_id].present?
    @posts = @posts.by_average_score(params[:avg_score]) if params[:avg_score].present?
  end

  def show
    @comment_form = Comment.new
  end

  def new
    @post = Post.new
    authorize @post
  end

  def edit
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    authorize @post

    if @post.save
      flash[:notice] = "Post created"
      PostWorker.perform_in(30.minutes, @post.id)
      redirect_to @post
    else
      render :new
    end
  end

  def update
    authorize @post
    if @post.update(post_params)
      flash[:notice] = "Post updated"
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    authorize @post
    
    if @post.destroy
      flash[:notice] = "Post deleted"
      redirect_to posts_path
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end