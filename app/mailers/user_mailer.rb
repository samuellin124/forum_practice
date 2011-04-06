class UserMailer < ActionMailer::Base
  default :from => "slin@optimiscorp.com"

  def new_post(user, post)

    mail :to => user.email,
         :subject => "#{post.author} created a new post No.#{post.id} on #{post.title}",
         :body => "#{post.content}"
  end
end
