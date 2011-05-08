class MoviesThemes < ActiveRecord::Migration
  def self.up
      create_table :movies_themes, :id => false do |t|
        t.column :movie_id, :integer, :null => false
        t.column :theme_id, :integer, :null => false
      end

      # add index
      add_index :movies_themes, [:movie_id, :theme_id]
      add_index :movies_themes, :theme_id
  end

  def self.down
    drop_table :movies_themes
  end
end
