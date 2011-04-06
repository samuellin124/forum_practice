class ForumsController < ApplicationController

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
      redirect_to forums_url
    else
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
      redirect_to forums_url
    else
      render :edit
    end
  end

  def destroy
    @forum = Forum.find(params[:id])
    if @forum.destroy
      flash[:notice] = 'Forum deleted'
    end
    redirect_to forums_path
  end
end
