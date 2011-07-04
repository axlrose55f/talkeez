class Movie < ActiveRecord::Base
ajaxful_rateable :stars => 5 , :cache_column => :rating
cattr_reader :per_page
@@per_page = 6

acts_as_reviewable

attr_accessor :image_url
attr_accessor :review_title
attr_accessor :review_text
attr_accessor :artist_name  # used in edit cast view

has_many   :trivia
has_many :awards,
         :class_name => "MovieAward"
has_and_belongs_to_many :genres,
                        :join_table => "movies_genres"
has_and_belongs_to_many :themes,
                        :join_table => "movies_themes"

def self.search(search_param, page)
  if search_param
   search_condition = ['name LIKE ?', "%#{search_param}%"]
  else
   search_condition = ['rating > 3']
  end
  paginate :page => page,
		     :conditions => search_condition,
		     :order => 'rating DESC'
end


# Roles Cast relation ####
has_many :movie_roles, :class_name => "MovieRole"

has_many :artists, :through => :movie_roles do
  def as(role)
    role_id = Role.find(:first, :conditions => [ "name = ?", role], :select => "id")
    find :all, :conditions => ['role_id = ?', role_id]
  end
  def role(role_id)
    find :all, :conditions => ['role_id in (?)', role_id]
  end
  def cast_type(type)
    casts = Role.find(:all, :conditions => [ "role_type in (?)", type], :select => "id")
    find :all, :conditions => ['role_id in (?)', casts]
  end
  
  def cast
    cast_type('cast')
  end
  def main_cast
    cast_type('ProductionCrew')
  end  
  def crew
    cast_type('crew')
  end  
  def artist
    as('artist')
  end  
  def lead
    role([1,2])
  end
  def heroines
    role(2)
  end
  def director
    role(68)
  end
  def producer
    role(102)
  end
  def banner
    role(41)
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
                    " where mr.artist_id = a.id and mr.role_id = r.id and r.role_type = 'cast' and mr.movie_id = ?", movie_id])
  end
  def crew_list(movie_id)
     find_by_sql( [ "select a.*, r.name as role_name, r.id as role_id, mr.id as mar_id " + 
                   "from artists as a, roles as r, movies_artists_roles as mr " +                   
                   " where mr.artist_id = a.id and mr.role_id = r.id and r.role_type in ('crew', 'ProductionCrew') and mr.movie_id = ?", movie_id])
  end
end


      
has_attached_file :image, 
				  :styles => { :medium => {:geometry => "175x175", :format => 'png'}, 
				               :thumb =>  {:geometry =>"80x80>" , :format => 'png'}
				             },
				  :default_url => "/images/:class/default/:style_missing_movie.png",           
                  :url => "/images/:class/:id/:style_:id_:name.:extension",
                  :path => ":rails_root/public/images/:class/:id/:style_:id_:name.:extension"

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
