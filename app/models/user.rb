class User < ActiveRecord::Base
  acts_as_authentic

  has_attached_file :image, 
                      :url => "/images//:class/:id/:style_:basename.:extension",
                      :path => ":rails_root/public/images/:class/:id/:style_:basename.:extension"

  validates_attachment_presence :image

  validates_attachment_content_type :image, 
                                     :content_type => ['image/jpeg','image/gif','image/png'],
                                     :message => "Must be a image of type png, jpeg or gif"
end
