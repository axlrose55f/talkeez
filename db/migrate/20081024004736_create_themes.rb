class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.column :name,          :string
      t.column :description,   :text
    end
  end

  def self.down
    drop_table :themes
  end
end
