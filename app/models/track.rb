class Track < ActiveRecord::Base
  belongs_to :album
  belongs_to :genre
  belongs_to :raga
  belongs_to :mood
  belongs_to :lyricist,
             :class_name => "Artist",
             :foreign_key => "lyricist_id"
end
