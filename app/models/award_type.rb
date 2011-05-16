class AwardType < ActiveRecord::Base
# givinb this relation a better name called categories. 
# By default it would have been  has_many :award_categories
has_many :categories,  
         :class_name => "AwardCategories"


has_attached_file :image, 
                  :url => "/images//:class/:id/:style_:basename.:extension",
                  :path => ":rails_root/public/images/:class/:id/:style_:basename.:extension"
#validates_attachment_presence :image
validates_attachment_content_type :image, :content_type => ['image/jpeg','image/gif','image/png']
end
