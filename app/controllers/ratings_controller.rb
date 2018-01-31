class RatingsController < ApplicationController
  before_action :set_post, only: [:create]

  def create
    @rating = @post.ratings.build(score: rating_params)
    @rating.user = current_user
    authorize @rating
    
    respond_to do |format|
      if @rating.save
        format.json { render json: @rating }
      else
        format.json { render json: @rating.errors }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def rating_params
    params.require(:score)
  end
end
