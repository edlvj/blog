class PostWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find_by(id: post_id)
    post.destroy if post.average_rating.to_i <= 3
  end
end
