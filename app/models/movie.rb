class Movie < ActiveRecord::Base
ajaxful_rateable :stars => 5 , :cache_column => :rating
cattr_reader :per_page
@@per_page = 3

attr_accessor :image_url

has_many   :trivia
has_many :awards,
         :class_name => "MovieAward"
has_and_belongs_to_many :genres,
                        :join_table => "movies_genres"
has_and_belongs_to_many :themes,
                        :join_table => "movies_themes"


def self.search(search, page)
  if search
   search_condition = ['name LIKE ?', "%#{search}%"]
  else
   search_condition = []
  end
   paginate :page => page,
		     :conditions => search_condition,
		     :order => 'name'  
end


# Roles Cast relation ####
has_many :movie_roles, :class_name => "MovieRole"

has_many :artists, :through => :movie_roles do
  def as(role)
    find :all, :conditions => ['role_id = ?', role]
  end  
  def heroes
    find :all, :conditions => ['role_id in (1,2)']
  end
  def heroines
    find :all, :conditions => ['role_id = 2']
  end
  def director
    find :all, :conditions => ['role_id = 3']
  end
  def producer
    find :all, :conditions => ['role_id = 4']
  end
end

has_many :roles, :through => :movie_roles do
  def cast
    find :all, :conditions => ["role_type = 'cast'"]
  end
  def crew
    find :all, :conditions => ["role_type = 'crew'"]
  end
end

has_many :cast, :class_name  => "MovieRole" do
  def cast_list(movie_id)
     find_by_sql( [ "select a.*, r.name as role_name, r.id as role_id, mr.id as mar_id " + 
                   "from artists as a, roles as r, movies_artists_roles as mr " +
                   " where mr.artist_id = a.id and mr.role_id = r.id and r.role_type = 'cast' and mr.movie_id = ?",
                   movie_id])
  end
  def crew_list(movie_id)
     find_by_sql( [ "select a.*, r.name as role_name, r.id as role_id, mr.id as mar_id " + 
                   "from artists as a, roles as r, movies_artists_roles as mr " +
                   " where mr.artist_id = a.id and mr.role_id = r.id and r.role_type = 'crew' and mr.movie_id = ?",
                   movie_id])
  end
end


# has_many :cast, :class_name  => "MovieRole",
#          :finder_sql => "select a.*, r.name as role_name, r.id as role_id from artists as a, roles as r, movies_artists_roles as mr where mr.artist_id = a.id and mr.role_id = r.id and mr.movie_id = 1"
# 
#          
has_attached_file :image, 
                   :url => "/images/:class/:id/:style_:basename.:extension",
                   :path => ":rails_root/public/images/:class/:id/:style_:basename.:extension"

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
