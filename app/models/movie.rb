class Movie < ActiveRecord::Base
has_many   :trivia
has_and_belongs_to_many :awards,
                        :join_table => "movies_awards"
has_and_belongs_to_many :genres,
                        :join_table => "movies_genres"
has_and_belongs_to_many :themes,
                        :join_table => "movies_themes"

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

has_many :roles, :through => :movie_roles

has_many :cast, :class_name  => "MovieRole" do
  def cast_list(movie_id)
     find_by_sql( [ "select a.*, r.name as role_name, r.id as role_id, mr.role_id as mar_id " + 
                   "from artists as a, roles as r, movies_artists_roles as mr " +
                   " where mr.artist_id = a.id and mr.role_id = r.id and mr.movie_id = ?",
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

validates_attachment_presence :image

validates_attachment_content_type :image, 
                                  :content_type => ['image/jpeg','image/gif','image/png'],
                                  :message => "Must be a image of type png, jpeg or gif"
end
