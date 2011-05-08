class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.column :name,              :string
      t.column :country,           :string
      t.column :language,          :string
      t.column :studio,            :string
      t.column :color,             :string
      t.column :certification,     :string
      t.column :image_url,         :string
      t.column :keywords,          :text
      t.column :description,       :text
      t.column :aspect_ratio,      :string
      t.column :year,              :date
      t.column :run_time,          :int
      t.column :rating,          :int      
    end

  end

  def self.down
    drop_table :movies
  end
end
