class CreateMoods < ActiveRecord::Migration
  def self.up
    create_table :moods do |t|
      t.column :name,          :string
      t.column :description,   :text
    end
  
  execute "alter table tracks add  constraint fk_tracks_mood
              foreign key (mood_id) references moods(id)"
  end
  
  def self.down
    drop_table :moods
  end
end
