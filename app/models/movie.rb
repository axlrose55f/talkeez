class Movie < ActiveRecord::Base


### new attributes ########
attr_accessor :image_url
attr_accessor :review_title
attr_accessor :review_text
attr_accessor :artist_name  # used in edit cast view


###### Plugins ###########
cattr_reader :per_page
@@per_page = 10

# ajaxful rating 
ajaxful_rateable :stars => 5 , :cache_column => :rating

# suppor treviews using acts_as_reviewable plugin
acts_as_reviewable

# Attach videos using video_attachments
video_attachments

# has an auditor for modifications
has_auditor :class_name => 'Audit'


has_many   :trivia

has_many :movie_awards,  :class_name  => "MovieAward"

has_many :awards, :through => :movie_awards, :conditions => { "movies_awards.active" => true }

has_many :movie_genres, :class_name => "MovieGenre" 

has_many :genres, :through => :movie_genres , :conditions => { "movies_genres.active" => true }
  

# has_and_belongs_to_many :genres,
#                         :join_table => "movies_genres"
has_and_belongs_to_many :themes,
                        :join_table => "movies_themes"


### Scopes #########

 named_scope :active , :conditions => ["movies.active = 1"]
 named_scope :pending , :conditions => ["movies.active = 0"]
 named_scope :rated , lambda { |*rate| { :conditions => ["movies.rating > ?",(rate.first || 4)] } }
 
 #named_scope :latest, lambda { {:conditions => ['year between ? and ?', Date.today.beginning_of_year(), Date.today]}}
 named_scope :latest, lambda { {:order => 'year DESC'}}
 
 named_scope :after, lambda { |*args| { :conditions => ['year > ?', (args.first || Date.today.beginning_of_year() )] }}

 named_scope :limit, lambda { |*num| { :limit => (num.first || 10) } }
 named_scope :order, lambda { |*order| { :order => order.flatten.first || 'rating DESC' } }

#### Methods #########

def self.search(search_param, page)
  if search_param
   search_condition = ['active = 1 and name LIKE ?', "%#{search_param}%"]
  else
   search_condition = ['active = 1 and rating > 3']
  end
  paginate(:page => page, :conditions => search_condition , :order => 'rating DESC')
end

def active_awards(user)
	if user 
      Award.find_by_sql( [ "select a.*, ar.name as artist_name, ar.id as artist_id, ma.id as ma_id, ma.year as year " +
                           " from awards as a, movies_awards as ma, artists as ar " +                   
                           " where ma.active = 1 and ar.id = ma.artist_id and ma.award_id = a.id " + 
                           " and  ma.movie_id = ? order by ma.year DESC", id])
	else
	  Award.find_by_sql( [ "select a.*, ar.name as artist_name, ar.id as artist_id, ma.id as ma_id, ma.year as year " +
                           " from awards as a, movies_awards as ma, artists as ar " +                   
                           " where ma.active = 1 and ar.id = ma.artist_id and ma.award_id = a.id " + 
                           " and  ma.movie_id = ? order by ma.year DESC", id])
	end
end

def active_genres(user)
    if user
      genres =  self.movie_genres.active  
	  pending_list = MovieGenre.pending_objects(user)

	  list = []
	  genres.each do |g| 
		list << g.genre_id
	  end
	  
	  pending_list.each do |g|
	     if(g.event == "destroy")
  		   list.delete(g.genre_id)
  		 else
  		   list << g.genre_id
  		 end
	  end
     Genre.find(list) 
   else
    self.genres 
   end
end

def active_videos(user)
  if user
    videos =  self.video_attachments.active
    pending_list = VideoAttachment.pending_objects(user)
    
    list = []
	videos.each do |g| 
		list << g.video_id
	end
	  
	pending_list.each do |g|
	     if(g.event == "destroy")
  		   list.delete(g.video_id)
  		 else
  		   list << g.video_id
  		 end
	end
    Video.find(list)    
    
  else
    self.videos
  end
end


def active_artists_leads(user)
   arr = self.active_artists(user, [1,2])
   arr.concat(self.active_artists(user, [3,4,5,10]))
   arr
end

def active_artists(user,roles)
  if user
    m_roles =  self.movie_roles.active
    pending_list = MovieRole.pending_objects(user)
    
    # consolidate all roles
	pending_list.each do |g|
	     if(g.event == "destroy")
  		   m_roles.delete(g)
  		 else
  		   m_roles << g
  		 end
	 end
    
    # filter out the roles
    list = []
    m_roles.each do|r|
      list << r.artist_id unless roles.index(r.role_id).nil?    
    end

    Artist.find(list)    
    
  else
    self.artists.role(roles)
  end
end

def show_artists(user,role_type_list)
  if user
    m_roles =  self.movie_roles.active
    pending_list = MovieRole.pending_objects(user)
    
    # consolidate all roles
	role_updates = {}
	pending_list.each do |g|
	     if(g.event == "destroy")
  		   m_roles.delete(g)
  		 elsif(g.event == "update")   
  		   role_updates[g.id.to_s] = g.role_id
  		 else
  		   m_roles << g
  		 end
	 end
    
    # filter out the roles
    list = m_roles.map {|r| r.id }
    
    artists = Artist.find_by_sql( [ "select a.*, r.name as role_name, r.id as role_id, mr.id as mar_id " + 
                         "from artists as a, roles as r, movies_artists_roles as mr " +                   
                         " where mr.artist_id = a.id and mr.role_id = r.id " + 
                         " and r.role_type in (?) and mr.id  in (?)", role_type_list, list])       

    # fianlly get any updates
    result = []
    if(!role_updates.empty?) 
      @roles = {}
      Role.find(role_updates.values).map { |u| @roles[u.id] = u.name }
      
      artists.each do |a|
         if(role_updates.has_key? a.mar_id ) 
            a["role_name"] = @roles[role_updates[a.mar_id]]
            a["role_id"] = role_updates[a.mar_id]
         end
         result << a 
      end
    else 
      result = artists
    end    
    result
  else
    self.cast.cast_list(role_type_list,id)
  end
end




# Roles Cast relation ####
has_many :movie_roles, :class_name => "MovieRole" 

has_many :artists, :through => :movie_roles , :conditions => { "movies_artists_roles.active" => true } do
  def as(role)
    role_id = Role.find(:first, :conditions => [ "name = ?", role], :select => "id")
    find :all, :conditions => ['role_id = ?', role_id]
  end
  def role(role_id)
    find :all, :conditions => ['role_id in (?)', role_id]
  end
  def cast_type(type)
    casts = Role.find(:all, :conditions => [ "role_type in (?)", type], :select => "id")
    find :all, :conditions => ['role_id in (?)', casts],  :order => 'role_id ASC'
  end
  
  def cast
    cast_type('cast')
  end
  def main_crew
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
  
  def cast_list(role_type_list, movie_id)
     Artist.find_by_sql( [ "select a.*, r.name as role_name, r.id as role_id, mr.id as mar_id " + 
                    "from artists as a, roles as r, movies_artists_roles as mr " +                   
                    " where mr.active = 1 and mr.artist_id = a.id and mr.role_id = r.id and r.role_type in (?) and mr.movie_id = ?", role_type_list, movie_id])
  end
end


      
has_attached_file :image, 
				  :styles => { :medium => {:geometry => "200x200", :format => 'png'}, 
				               :thumb =>  {:geometry =>"80x80>" , :format => 'png'}
				             },
				  :default_url => "/data/images/:class/default/:style_missing_movie.png",           
                  :url => "/data/images/:class/:id/:style_:id_:name.:extension",
                  :path => ":rails_root/public/data/images/:class/:id/:style_:id_:name.:extension"

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
