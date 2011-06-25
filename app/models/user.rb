class User < ActiveRecord::Base
  acts_as_authentic
  ajaxful_rater
  has_many :roles, 
           :class_name => "UserRole"
  
  def name
    "#{self[:username]}"
  end
  
  def role_symbols
    roles.map do |r|
      r.role.name.underscore.to_sym
    end
  end
  
  def before_connect(facebook_session)
   # self.first_name = facebook_session.first_name
   # self.last_name = facebook_session.last_name
    self.email = facebook_session.email
    self.username = "#{facebook_session.first_name}.#{facebook_session.last_name}"
    self.password = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{self.username}--")[0,6]
    self.password_confirmation = self.password
    #self.active = true
  end
  
    
  has_attached_file :image, 
 				    :styles => { :medium => {:geometry => "175x175", :format => 'png'}, 
				  				 :thumb =>  {:geometry =>"80x80>" , :format => 'png'}
				               },
				  	 :default_url => "/images/:class/default/:style_missing_user.png", 
                     :url => "/images//:class/:id/:style_:id_:name.:extension",
                     :path => ":rails_root/public/images/:class/:id/:style_:id_:name.:extension"

#  validates_attachment_presence :image

  validates_attachment_content_type :image, 
                                     :content_type => ['image/jpeg','image/gif','image/png'],
                                     :message => "Must be a image of type png, jpeg or gif"
end
