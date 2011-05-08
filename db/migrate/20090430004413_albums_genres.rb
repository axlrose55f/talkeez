class AlbumsGenres < ActiveRecord::Migration
  def self.up
     create_table :albums_genres, :id => false do |t|
        t.column :album_id, :integer, :null => false
        t.column :genre_id, :integer, :null => false
      end

      # add index
      add_index :albums_genres, [:album_id, :genre_id]
      add_index :albums_genres, :genre_id
  end

  def self.down
    drop_table :albums_genres
  end
end
