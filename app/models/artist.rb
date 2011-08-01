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
					   " where mr.movie_id = m.id and mr.role_id = r.id and mr.artist_id = ? order by m.year ASC",
					   artist_id])
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
