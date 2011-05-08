class MoviesArtistsRoles < ActiveRecord::Migration
  def self.up
      create_table :movies_artists_roles  do |t|
        t.column :movie_id,  :integer, :null => false
        t.column :artist_id, :integer, :null => false
        t.column :role_id,   :integer, :null => false
      end

      # add index
      add_index :movies_artists_roles, [:movie_id, :artist_id, :role_id]
      add_index :movies_artists_roles, [:artist_id, :role_id]
      add_index :movies_artists_roles, :role_id
  end

  def self.down
    drop_table :movies_artists_roles
  end
end
