class MovieAward < ActiveRecord::Base
 self.table_name = "movies_awards"
 belongs_to :movie
 belongs_to :artist
 belongs_to :award
 
  #default_scope :conditions => { :active => 1 }
 named_scope :pending , :conditions => ["active = 0"]
 named_scope :active , :conditions => ["active = 1"]
 
 
  # has an auditor for modifications
 has_auditor :class_name => 'Audit'
 
 def name
   categories.full_name
 end 
 
end