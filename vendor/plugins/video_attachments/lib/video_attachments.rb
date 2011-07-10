module VideoAttachments #:nodoc:

      def self.included(base)
        base.extend ClassMethods  
      end

      module ClassMethods
        def video_attachments
          has_many :video_attachments , :as => :videoable, :dependent => :destroy
          has_many :videos, :through => :video_attachments
          include VideoAttachments::InstanceMethods
          extend VideoAttachments::SingletonMethods
        end
      end
      
      # This module contains class methods
      module SingletonMethods
        
      end #SingletonMethods
      
      # This module contains instance methods
      module InstanceMethods
        # Helper method that defaults the current time to the submitted field.
        def add_video(video)
          videos << video
        end
#         
#         def review(title, review_text, user)
#            review = if reviewed_by?(user)
#               review_by(user)
#            else
#              returning reviews.build do |r|
#               r.user = user
#              end
#            end
#           review.title = title 
#           review.text = review_text
#           review.save!
#         end
#         
#         def review_by(user)
#       	   reviews.find_by_user_id(user.id)
#     	end
#         
#         def reviewed_by?(user)
#       	  !review_by(user).nil?
#     	end
#         
#         def reviewers
# 	      sql = "SELECT DISTINCT u.* FROM users u "\
#     		    "INNER JOIN reviews r ON u.id = r.user_id WHERE "
# 
# 	      sql << self.class.send(:sanitize_sql_for_conditions, {
#     						     :reviewable_id => id,
# 						         :reviewable_type => self.class.base_class.name						         
# 							 }, 'r')
# 
# 	      User.find_by_sql(sql)
#     	end       
     end # InstanceMethods
end

class ActiveRecord::Base
  include VideoAttachments
end
