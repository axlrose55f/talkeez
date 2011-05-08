class Award < ActiveRecord::Base
has_and_belongs_to_many :movies,
                        :join_table => "movies_awards"   

has_attached_file :image, 
                  :url => "/images//:class/:id/:style_:basename.:extension",
                  :path => ":rails_root/public/images/:class/:id/:style_:basename.:extension"
validates_attachment_presence :image
validates_attachment_content_type :image, :content_type => ['image/jpeg','image/gif','image/png']
end
