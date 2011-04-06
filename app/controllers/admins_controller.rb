class AdminsController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  layout 'admin'

  def redirect_unless_admin
    unless is_admin?
      redirect_to :root, :notice => "You must have admin privilege to enter the console"
    end
  end

  def is_admin?
    current_user && current_user.is_admin?
  end

end
