class PostObserver < ActiveRecord::Observer

  def after_create(post)
    Resque.enqueue(Post, post.id)
  end

end