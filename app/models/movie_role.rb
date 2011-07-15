class MovieRole < ActiveRecord::Base
 self.table_name = "movies_artists_roles"
 belongs_to :movie
 belongs_to :artist
 belongs_to :role
 
 attr_accessor :movie_name
 attr_accessor :artist_name  
end