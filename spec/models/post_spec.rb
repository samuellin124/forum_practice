require 'spec_helper'

describe Post, "#send_mails" do

  it 'should deliver notifications to users after a new post created' do
    @post = Post.new
    @user = User.create(:email => 'abc@wsdf.com', :password => '12345678')
    @user.save
    UserMailer.should_receive(:new_post).with(@user, @post).and_return(mock(:deliver).as_null_object)
    @post.send_mails
  end

end