module PostsHelper

  def can_post?(user, post)
    if is_admin?(user)
      true
    else
      user_signed_in? && post_user?(post, user)
    end
  end

  def is_admin?(user)
    user.is_admin? unless user.nil?
  end

  def post_user?(post, user)
    post.user_id==user.id
  end

  def attachment_helper(post)
    
    if post.photo_file_name.nil?
      'No image available'
    else
      image_tag post.photo.url(:small)
    end

  end

end
