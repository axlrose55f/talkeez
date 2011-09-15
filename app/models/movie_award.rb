class MovieAward < ActiveRecord::Base
 self.table_name = "movies_awards"
 belongs_to :movie
 belongs_to :artist
 belongs_to :award
 
 ### new attributes ########
 cattr_accessor :award_count
 
  #default_scope :conditions => { :active => 1 }
 named_scope :pending , :conditions => ["active = 0"]
 named_scope :active , :conditions => ["active = 1"]
 
 
  # has an auditor for modifications
 has_auditor :class_name => 'Audit'
 
 def name
   categories.full_name
 end 
 
 def self.top_movies(user)
	if user 
      find_by_sql("select movie_id, count(movie_id) as award_count from movies_awards " +
                           " group by movie_id order by count(movie_id) desc limit 10")
	else
      find_by_sql("select movie_id, count(movie_id) as award_count from movies_awards " +
                           " group by movie_id order by count(movie_id) desc limit 10")
    end
    
end


 def self.top_artists(user)
	if user 
      find_by_sql("select artist_id, count(artist_id) as award_count from movies_awards " +
                           " group by artist_id order by count(artist_id) desc limit 10")
	else
      find_by_sql("select artist_id, count(artist_id) as award_count from movies_awards " +
                           " group by artist_id order by count(artist_id) desc limit 10")
	end
end
 
end