class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.column :name,        :string
      t.column :biography,   :text
      t.column :image_url,   :string  
      t.column  :dob,        :date
      t.column  :birth_place,  :string
      t.column  :country,     :string
      t.column  :birth_name,  :string 
      
      
      t.column  :height,              :int
      t.column  :weight,              :int
      t.column  :marital_status,  :string
      t.column  :education,       :string
      t.column  :star_sign,       :string
      t.column  :religion,       :string     
    end    
  end

  def self.down
    drop_table :artists
  end
end
