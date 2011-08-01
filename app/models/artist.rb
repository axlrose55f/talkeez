class Artist < ActiveRecord::Base
 

  attr_accessor :movie_name
  attr_accessor :image_url
  
  ### realtion ships ####
  has_many :awards,
           :class_name => "MovieAward"
 
  has_many :movie_roles, :class_name => "MovieRole"
  
  has_many :roles, :through => :movie_roles
  
  has_and_belongs_to_many :movies,
                          :join_table => "movies_artists_roles"


	has_many :movies, :through => :movie_roles do
	  def as(role)
		find :all, :conditions => ['role_id = ?', role]
	  end  
	  def roles(artist_id)
		 find_by_sql( [ "select m.*, r.name as role_name, r.id as role_id, mr.id as mar_id " + 
					   "from movies as m, roles as r, movies_artists_roles as mr " +
					   " where mr.movie_id = m.id and mr.role_id = r.id and mr.artist_id = ? order by m.year ASC", artist_id])
	  end
	end         


  #### plugins #######
  cattr_reader :per_page
  @@per_page = 10
 
  ajaxful_rateable :stars => 5 , :cache_column => :rating
  
  # Attach videos using video_attachments plugin
  video_attachments

  # has an auditor for modifications
  has_auditor :class_name => 'Audit'
  


### named Scopes #####
 named_scope :active , :conditions => ["artists.active = 1"]
 named_scope :pending , :conditions => ["artists.active = 0"]
 named_scope :rated , lambda { |*rate| { :conditions => ["artists.rating > ?",(rate.first || 4)] } }

 named_scope :limit, lambda { |*num| { :limit => (num.first || 10) } }
 named_scope :order, lambda { |*order| { :order => order.flatten.first || 'rating DESC' } }

#### Methods #######

def self.search(search, page)
  if search
   search_condition = ['active = 1 and name LIKE ?', "%#{search}%"]
  else
   search_condition = ['active = 1 and rating > 3']
  end
   paginate :page => page,
		     :conditions => search_condition,
		     :order => 'rating DESC'  
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

def show_movies(user, limit_num = 8)
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
    list = m_roles.map { |r| r.movie_id }      
    movies = []
    begin
     movies = Movie.find(list[0..(limit_num-1)])    
    rescue ActiveRecord::RecordNotFound 
    end
    movies
  else
    self.artist.movies.limit(limit_num)
  end
end

def filmography(user, limit_num = nil)
  limit = limit_num.nil? ? "" : " LIMIT " + limit_num.to_s
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

    movies = Movie.find_by_sql( [ "select m.*, r.name as role_name, r.id as role_id, mr.id as mar_id " + 
	   				     "from movies as m, roles as r, movies_artists_roles as mr " +
					     " where mr.movie_id = m.id and mr.role_id = r.id and mr.id in (?) order by m.year ASC" + limit, list])
     

    # fianlly get any updates
    result = []
    if(!role_updates.empty?) 
      @roles = {}
      Role.find(role_updates.values).map { |u| @roles[u.id] = u.name }
      
      movies.each do |a|
         if(role_updates.has_key? a.mar_id ) 
            a["role_name"] = @roles[role_updates[a.mar_id]]
            a["role_id"] = role_updates[a.mar_id]
         end
         result << a 
      end
    else 
      result = movies
    end    
    result
  else
    Movie.find_by_sql([ "select m.*, r.name as role_name, r.id as role_id, mr.id as mar_id " + 
		 			    "from movies as m, roles as r, movies_artists_roles as mr " +
					    " where mr.movie_id = m.id and mr.role_id = r.id and mr.artist_id = ? order by m.year ASC" + limit, id])
  end
end




has_attached_file :image,
				  :styles => { :medium => {:geometry => "175x175", :format => 'png'}, 
				               :thumb =>  {:geometry =>"80x80>" , :format => 'png'}
				             },
				  :default_url => "/data/images/:class/default/:style_missing_artist.png",
                  :url => "/data/images/:class/:id/:style_:id_:name.:extension",
                  :path => ":rails_root/public/data/images/:class/:id/:style_:id_:name.:extension"

#validates_attachment_presence :image
before_validation :image_from_url, :if => :image_url_provided?
 
validates_attachment_content_type :image, 
                                   :content_type => ['image/jpeg','image/gif','image/png'],
                                   :message => "Must be a image of type png, jpeg or gif"

validates_presence_of :name, :biography
validates_uniqueness_of :name , :scope => :dob


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
