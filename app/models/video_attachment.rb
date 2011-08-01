class VideoAttachment < ActiveRecord::Base
  belongs_to :video 
  belongs_to :videoable, :polymorphic => true
  
  named_scope :pending , :conditions => ["active = 0"]
  named_scope :active , :conditions => ["active = 1"]
  
 # has an auditor for modifications
 has_auditor :class_name => 'Audit'
end