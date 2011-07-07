require "open-uri"
class AwardType < ActiveRecord::Base

attr_accessor :image_url

has_many :categories,  
         :class_name => "AwardCategories"


has_attached_file :image,
				  :styles => { :medium => {:geometry => "100x100", :format => 'png'}, 
				               :thumb =>  {:geometry =>"60x60>" , :format => 'png'}
				             },
				  :default_url => "/data/images/:class/default/:style_missing.png",
                  :url => "/data/images/:class/:id/:style_:id_:name.:extension",
                  :path => ":rails_root/public/data/images/:class/:id/:style_:id_:name.:extension"
                  
before_validation :image_from_url, :if => :image_url_provided?

#validates_attachment_presence :image
validates_attachment_content_type :image, :content_type => ['image/jpeg','image/gif','image/png']

  def image_url_provided?
    !self.image_url.blank?
  end

 # helper method to get image from url
 def image_from_url
    io = open(URI.parse(image_url))
    def io.original_filename; base_uri.path.split('/').last; end
    self.image = io.original_filename.blank? ? nil : io
    rescue  # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...) 
 end


end
