class Admin::ForumsController < AdminsController

  before_filter :redirect_unless_admin

  def index
    @forums = Forum.all
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(params[:forum])
    if @forum.save
      flash[:notice] = 'New forum created'
      redirect_to admin_forums_url
    else
      flash[:error] = @forum.errors.full_messages
      render :new
    end
  end

  def show
    @forum = Forum.find(params[:id])
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])
    @forum.update_attributes(params[:forum])

    if @forum.save
      flash[:notice] = 'Forum updated'
      redirect_to admin_forums_url
    else
      flash[:error] = @forum.errors.full_messages
      render :edit
    end
  end

  def destroy
    @forum = Forum.find(params[:id])
    if @forum.destroy
      flash[:notice] = 'Forum deleted'
    end
    redirect_to admin_forums_path
  end
end
