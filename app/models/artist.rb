class Artist < ActiveRecord::Base
  ajaxful_rateable :stars => 5 , :cache_column => :rating
  
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
  def roles(artist_id)
     find_by_sql( [ "select m.*, r.name as role_name, r.id as role_id, mr.id as mar_id " + 
                   "from movies as m, roles as r, movies_artists_roles as mr " +
                   " where mr.movie_id = m.id and mr.role_id = r.id and mr.artist_id = ?",
                   artist_id])
  end
end         

attr_accessor :image_url

has_many :roles, :through => :movie_roles



has_attached_file :image, 
                    :url => "/images/:class/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/images/:class/:id/:style_:basename.:extension"
                    
#validates_attachment_presence :image
before_validation :image_from_url, :if => :image_url_provided?
 
validates_attachment_content_type :image, 
                                   :content_type => ['image/jpeg','image/gif','image/png'],
                                   :message => "Must be a image of type png, jpeg or gif"

# helper method to get image from url
private
  def image_url_provided?
    !self.image_url.blank?
  end


 def image_from_url
    io = open(URI.parse(image_url))
    def io.original_filename; base_uri.path.split('/').last; end
    self.image = io.original_filename.blank? ? nil : io
    rescue  # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...) 
 end

end
