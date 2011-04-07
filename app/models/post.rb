class Post < ActiveRecord::Base

  attr_accessible :is_admin,
                  :title,
                  :author,
                  :forum_id,
                  :user_id,
                  :content,
                  :photo

        
  scope :order_desc, order('created_at DESC')

  belongs_to :forum

  validates :title, :presence => true
  validates :author, :presence => true
  validates :content, :presence => true

  # Paperclip
  has_attached_file :photo, :styles => {:small => "150x150>"},
                    :url => "attachments/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/images/attachments/:id/:style/:basename.:extension"

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

#  after_create :send_mails
#
  def send_mails
    users = User.all
    users.find_each do |user|
       UserMailer.new_post(user, self).deliver
    end
  end

  def self.queue
    'send'
  end

  def self.perform(id)
    post = find(id)
    post.send_mails
  end

end
