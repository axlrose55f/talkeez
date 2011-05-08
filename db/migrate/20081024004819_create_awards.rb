class CreateAwards < ActiveRecord::Migration
  def self.up
    create_table :awards do |t|
      t.column :name,          :string
      t.column :description,   :text
    end
  end

  def self.down
    drop_table :awards
  end
end
