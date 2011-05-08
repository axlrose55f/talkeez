class MoviesAwards < ActiveRecord::Migration
  def self.up
    create_table :movies_awards, :id => false do |t|
      t.column :movie_id, :integer, :null => false
      t.column :award_id, :integer, :null => false
    end
    
    # add index
    add_index :movies_awards, [:movie_id, :award_id]
    add_index :movies_awards, :award_id
  end

  def self.down
    drop_table :movies_awards
  end
end
