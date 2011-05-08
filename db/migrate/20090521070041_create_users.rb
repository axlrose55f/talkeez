class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :username,            :null => true , :default => nil
      t.string    :email,               :null => true , :default => nil
      t.string    :crypted_password,    :null => true , :default => nil
      t.string    :password_salt,       :null => true , :default => nil
      t.string    :persistence_token,   :null => false 
      t.string    :single_access_token, :null => false
      t.string    :perishable_token,    :null => false
      t.string    :openid_identifier 
      t.timestamps
    end
    
     # add index
      add_index :users, :openid_identifier
  end

  def self.down
    drop_table :users
  end
end
