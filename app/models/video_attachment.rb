class VideoAttachment < ActiveRecord::Base
  belongs_to :video 
  belongs_to :videoable, :polymorphic => true
end