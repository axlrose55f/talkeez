class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
        t.column :name,                :string
        t.column :description,         :text
        t.column :image_url,           :string
        t.column :year,                :date
        t.column :movie_id,            :int
        t.column :music_director_id,   :int
        t.column :genre_id,            :int
        t.column :lyricist_id,         :int        
    end   
  
    execute "alter table albums add  constraint fk_albums_movies
             foreign key (movie_id) references movies(id)"
    execute "alter table albums add  constraint fk_albums_genres
             foreign key (genre_id) references genres(id)"
    execute "alter table albums add  constraint fk_albums_music_dir
             foreign key (music_director_id) references artists(id)"
    execute "alter table albums add  constraint fk_albums_lyricist
             foreign key (lyricist_id) references artists(id)"
  end

  def self.down
    drop_table :albums
  end
end
