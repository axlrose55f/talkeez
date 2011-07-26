class MovieGenre < ActiveRecord::Base
 self.table_name = "movies_genres"
 belongs_to :movie
 belongs_to :genre
 
 #default_scope :conditions => { :active => 1 }
 named_scope :pending , :conditions => ["active = 0"]
 
  # has an auditor for modifications
 has_auditor :class_name => 'Audit'
 
end