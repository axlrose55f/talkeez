class AwardCategories < ActiveRecord::Base
	belongs_to :award_type
	
	def type_name
	   award_type.name
	end	
	
	def full_name
	   "#{award_type.name} - #{name}"  
	end 
	
end
