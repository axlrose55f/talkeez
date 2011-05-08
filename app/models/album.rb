class Album < ActiveRecord::Base
belongs_to :music_director,
           :class_name => "Artist",
           :foreign_key => "music_director_id"
belongs_to :lyricist,
           :class_name => "Artist",
           :foreign_key => "lyricist_id"
belongs_to :movie
has_many   :tracks
has_and_belongs_to_many :genres,
                        :join_table => "albums_genres"
end
 