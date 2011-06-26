module ActsAsReviewable #:nodoc:

      def self.included(base)
        base.extend ClassMethods  
      end

      module ClassMethods
        def acts_as_reviewable
          has_many :reviews, :as => :reviewable, :dependent => :destroy
          include ActsAsReviewable::InstanceMethods
          extend ActsAsReviewable::SingletonMethods
        end
      end
      
      # This module contains class methods
      module SingletonMethods
        # Helper method to lookup for reviews for a given object.
        # This method is equivalent to obj.reviews
        def find_reviews_for(obj)
          reviewable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
         
          Review.find(:all,
            :conditions => ["reviewable_id = ? and reviewable_type = ?", obj.id, reviewable],
            :order => "created_at DESC"
          )
        end
        
        # Helper class method to lookup reviews for
        # the mixin reviewable type written by a given user.  
        # This method is NOT equivalent to Review.find_reviews_for_user
        def find_reviews_by_user(user) 
          reviewable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
          
          Review.find(:all,
            :conditions => ["user_id = ? and reviewable_type = ?", user.id, reviewable],
            :order => "created_at DESC"
          )
        end
        
      end #SingletonMethods
      
      # This module contains instance methods
      module InstanceMethods
        # Helper method that defaults the current time to the submitted field.
        def add_review(review)
          reviews << review
        end
        
        def review(title, review_text, user)
           review = if reviewed_by?(user)
              review_by(user)
           else
             returning reviews.build do |r|
              r.user = user
             end
           end
          review.title = title 
          review.text = review_text
          review.save!
        end
        
        def review_by(user)
      	   reviews.find_by_user_id(user.id)
    	end
        
        def reviewed_by?(user)
      	  !review_by(user).nil?
    	end
        
        def reviewers
	      sql = "SELECT DISTINCT u.* FROM users u "\
    		    "INNER JOIN reviews r ON u.id = r.user_id WHERE "

	      sql << self.class.send(:sanitize_sql_for_conditions, {
    						     :reviewable_id => id,
						         :reviewable_type => self.class.base_class.name						         
							 }, 'r')

	      User.find_by_sql(sql)
    	end       
     end # InstanceMethods
end

class ActiveRecord::Base
  include ActsAsReviewable
end
