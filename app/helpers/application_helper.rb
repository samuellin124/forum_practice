module ApplicationHelper

  def is_admin?(user)
    user.is_admin? unless user.nil?
  end

end
