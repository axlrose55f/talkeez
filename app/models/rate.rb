class Rate < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true
 
  cattr_reader :per_page
  @@per_page = 10
   
  ### Scopes ### 
  named_scope :limit, lambda { |*num| { :limit => (num.first || 10) } }
  
  attr_accessible :rate, :dimension

  def self.latest(num)
  	
  	Movie.find_by_sql( [ "select distinct m.* " +
                        " from movies as m INNER JOIN rates on m.id = rates.rateable_id " +                   
                        " where (`rates`.rateable_type = 'Movie') AND (m.active = 1) " + 
                        "  order by rates.created_at DESC limit ?",num])
  	
  end


end
