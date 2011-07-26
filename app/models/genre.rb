class Genre < ActiveRecord::Base

has_many :movie_genres, :class_name => "MovieGenre"

has_many :movies, :through => :movie_genres
# has_and_belongs_to_many :class_name,
#                         :join_table => "movies_genres"


end
