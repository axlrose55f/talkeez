class MovieAward < ActiveRecord::Base
 self.table_name = "movies_awards"
 belongs_to :movie
 belongs_to :artist
 belongs_to :categories,
			:class_name => "AwardCategories",
			:foreign_key => "award_id"

  # has an auditor for modifications
 has_auditor :class_name => 'Audit'
 
 def name
   categories.full_name
 end 
 
end