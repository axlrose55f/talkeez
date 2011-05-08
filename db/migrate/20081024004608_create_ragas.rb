class CreateRagas < ActiveRecord::Migration
  def self.up
    create_table :ragas do |t|
      t.column :name,          :string
      t.column :description,   :text
    end 

  execute "alter table tracks add  constraint fk_tracks_raga
               foreign key (raga_id) references ragas(id)"
  
  end  
  
  def self.down
    drop_table :ragas
  end
end
