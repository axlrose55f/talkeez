class CreateTrivias < ActiveRecord::Migration
  def self.up
    create_table :trivias do |t|
      t.column :movie_id,      :int
      t.column :description,   :text
    end
    execute "alter table trivias add  constraint fk_trivias_movies
             foreign key (movie_id) references movies(id)"
    
  end

  def self.down
    drop_table :trivias
  end
end
