class AwardCategories < ActiveRecord::Base
	belongs_to :award_type
	has_many :awards,
             :class_name => "MovieAward",
             :foreign_key => "award_id"
         
	def type_name
	   award_type.name
	end	
	
	def full_name
	   "#{award_type.name} - #{name}"  
	end 
	
end
