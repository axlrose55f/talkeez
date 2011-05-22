class Artist < ActiveRecord::Base
  acts_as_rateable 
  has_many :awards,
           :class_name => "MovieAward"
         
  has_many :music_director,
           :class_name => "Album",
           :foreign_key => "music_director_id"

  has_many :lyricist,
           :class_name => "Album",
           :foreign_key => "lyricist_id"
  has_and_belongs_to_many :movies,
                          :join_table => "movies_artists_roles"
  validates_presence_of :name, :biography
  validates_uniqueness_of :name
 # validates_format_of :image_url,
 #                     :with  => %r{\.(gif|png|jpg)$}i,
 #                     :message => "must be a url for a GID, PNG or JPG image"
                      
has_many :movie_roles, :class_name => "MovieRole"

has_many :movies, :through => :movie_roles do
  def as(role)
    find :all, :conditions => ['role_id = ?', role]
  end
end         

has_many :roles, :through => :movie_roles



has_attached_file :image, 
                    :url => "/images/:class/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/images/:class/:id/:style_:basename.:extension"
                    
#validates_attachment_presence :image
 
validates_attachment_content_type :image, 
                                   :content_type => ['image/jpeg','image/gif','image/png'],
                                   :message => "Must be a image of type png, jpeg or gif"


end
