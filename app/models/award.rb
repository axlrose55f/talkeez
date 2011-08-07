class Award < ActiveRecord::Base
	
	belongs_to :award_type,
			   :foreign_key => "type_id"
	
	has_many :movie_awards,
             :foreign_key => "award_id"
         
	def type_name
	   award_type.name
	end	
	
	def full_name
	   "#{award_type.name} - #{name}"  
	end 
	
 def self.getAwards(type_id, year)
   
   MovieAward.find_by_sql([ "select ma.*, a.name as a_name, a.type_name as type_name, ar.name as artist_name, m.name as movie_name " +					   	    
                            " from awards as a,  movies_awards as ma, artists as ar, movies as m " +                   
                            " where ma.active = 1 and ar.id = ma.artist_id and m.id = ma.movie_id and ma.award_id = a.id " + 
                            " and a.type_id = ? and ma.year =? order by a.id ASC", type_id, year])
   
 end
	
	
end
