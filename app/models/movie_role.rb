class MovieRole < ActiveRecord::Base
 self.table_name = "movies_artists_roles"
 belongs_to :movie
 belongs_to :artist
 belongs_to :role

 named_scope :pending , :conditions => ["active = 0"]
 named_scope :active , :conditions => ["active = 1"]

  
 # has an auditor for modifications
 has_auditor :class_name => 'Audit'
 
 attr_accessor :movie_name
 attr_accessor :artist_name
 attr_accessor :origin
end