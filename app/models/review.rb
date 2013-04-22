class Review < ActiveRecord::Base
  belongs_to :reviewable, :polymorphic => true
  
  # NOTE: Reviews belong to a user
  belongs_to :user
  
  ### Scopes ### 
  named_scope :latest, lambda { {:order => 'created_at DESC'}}
  named_scope :limit, lambda { |*num| { :limit => (num.first || 10) } }
  
  # Helper class method to lookup all reviews assigned
  # to all rateable types for a given user.
  def self.find_reviews_by_user(user)
    find(:all,
      :conditions => ["user_id = ?", user.id],
      :order => "created_at DESC"
    )
  end
end