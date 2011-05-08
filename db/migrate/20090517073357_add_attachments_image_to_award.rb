class AddAttachmentsImageToAward < ActiveRecord::Migration
  def self.up
    add_column :awards, :image_file_name, :string
    add_column :awards, :image_content_type, :string
    add_column :awards, :image_file_size, :integer
    add_column :awards, :image_updated_at, :datetime
  end

  def self.down
    remove_column :awards, :image_file_name
    remove_column :awards, :image_content_type
    remove_column :awards, :image_file_size
    remove_column :awards, :image_updated_at
  end
end
