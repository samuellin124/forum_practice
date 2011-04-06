class PostsController < ApplicationController

  before_filter :find_forum

  def index
    @posts = @forum.posts.order_desc.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @post = @forum.posts.new
  end

  def create

    @post = @forum.posts.create(params[:post])

    if @post.save
      redirect_to forum_posts_path, :notice => 'New post created'
    else
      flash[:error] = @post.errors.full_messages
      render :new
    end

  end

  def show
    @post = @forum.posts.find(params[:id])
  end

  def edit
    @post = @forum.posts.find(params[:id])
  end

  def update
    @post = @forum.posts.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to forum_post_path, :notice => 'Post updated'
    else
      flash[:error] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = @forum.posts.find(params[:id])
    if @post.destroy
      flash[:notice] = 'Post deleted'
    end
    redirect_to forum_posts_path
  end

  def find_forum
    @forum=Forum.find(params[:forum_id])
  end

end
