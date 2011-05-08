class MoviesGenres < ActiveRecord::Migration
  def self.up
      create_table :movies_genres, :id => false do |t|
        t.column :movie_id, :integer, :null => false
        t.column :genre_id, :integer, :null => false
      end

      # add index
      add_index :movies_genres, [:movie_id, :genre_id]
      add_index :movies_genres, :genre_id
  end

  def self.down
    drop_table :movies_genres
  end
end
