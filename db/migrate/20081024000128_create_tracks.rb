class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.column :title,                :string
      t.column :lyrics,               :text
      t.column :chords,               :text
      t.column :lenght,               :int
      t.column :album_id,             :int
      t.column :track_number,         :int
      t.column :video_url,            :string 
      t.column :genre_id,        :int
      t.column :raga_id,         :int
      t.column :mood_id,         :int
      t.column :lyricist_id,     :int           
    end
    
    execute "alter table tracks add  constraint fk_tracks_albums
             foreign key (album_id) references albums(id)"
     execute "alter table tracks add  constraint fk_tracks_lyricist
              foreign key (lyricist_id) references artists(id)"
     execute "alter table tracks add  constraint fk_tracks_genre
              foreign key (genre_id) references genres(id)"         


    
  end

  def self.down
    drop_table :tracks
  end
end


