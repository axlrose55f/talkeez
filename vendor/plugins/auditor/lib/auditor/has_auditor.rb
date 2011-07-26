module Auditor
  module Model

    def self.included(base)
      base.send :extend, ClassMethods
    end


    module ClassMethods
      # Declare this in your model to track every create, update, and destroy.  Each version of
      # the model is available in the `versions` association.
      #
      # Options:
      # :class_name   the name of a custom Version class.  This class should inherit from Version.
      # :ignore    an array of attributes for which a new `Version` will not be created if only they change.
      # :meta      a hash of extra data to store.  You must add a column to the `versions` table for each key.
      #            Values are objects or procs (which are called with `self`, i.e. the model with the paper
      #            trail).  See `Auditor::Controller.info_for_auditor` for how to store data from
      #            the controller.
      def has_auditor(options = {})
        # Lazily include the instance methods so we don't clutter up
        # any more ActiveRecord models than we have to.
        send :include, InstanceMethods

        # The version this instance was reified from.
        attr_accessor :version

	    cattr_accessor :version_class_name
        self.version_class_name = options[:class_name] || 'Version'
     
        cattr_accessor :ignore
        self.ignore = (options[:ignore] || []).map &:to_s

        cattr_accessor :meta
        self.meta = options[:meta] || {}

        # Indicates whether or not Auditor is active for this class.
        # This is independent of whether Auditor is globally enabled or disabled.
        cattr_accessor :auditor_active
        self.auditor_active = true

        has_one :version, :class_name => version_class_name, :as => :item

        before_create :before_create
        after_create  :record_create
        before_update :record_update
        #before_destroy :record_destroy
      end

      # Switches Auditor off for this class.
      def auditor_off
        self.auditor_active = false
      end

      # Switches Auditor on for this class.
      def auditor_on
        self.auditor_active = true
      end
      
    end

    # Wrap the following methods in a module so we can include them only in the
    # ActiveRecord models that declare `has_auditor`.
    module InstanceMethods
      # Returns true if this instance is the current, live one;
      # returns false if this instance came from a previous version.
      def live?
        version.nil?
      end
      
      def is_edited?
         !version.nil?
      end

      # Returns who put the object into its current state.
      def originator
        version_class.last.try :whodunnit
      end

      # Returns the object (not a Version) as it was at the given timestamp.
      def version_at(timestamp, reify_options={})
        # Because a version stores how its object looked *before* the change,
        # we need to look for the first version created *after* the timestamp.
        version = versions.after(timestamp).first
        version ? version.reify(reify_options) : self
      end

      # Returns the object (not a Version) as it was most recently.
      def previous_version
        preceding_version = version ? version.previous : versions.last
        preceding_version.try :reify
      end

      # Returns the object (not a Version) as it became next.
      def next_version
        # NOTE: if self (the item) was not reified from a version, i.e. it is the
        # "live" item, we return nil.  Perhaps we should return self instead?
        subsequent_version = version ? version.next : nil
        subsequent_version.reify if subsequent_version
      end
      
      # store  audit record for delete operation. if exiting record exits skip.
      def log_destroy_for_audit
         if switched_on? and not new_record?
           cur_version = Audit.with_item_keys(self.class.base_class.name, id).last
           cur_version = build_version if cur_version.nil?
           cur_version.attributes = merge_metadata(:event     => 'destroy',
                                	               :object    => object_to_string(self.clone),
                                           		   :whodunnit => Auditor.whodunnit)
           cur_version.save
          end       	  
      end

      # Admin operations
      
#       def approve_create
#        logger.debug("Findeme in approve_create User: #{Auditor.whodunnit.username} ")
#         if switched_on? && moderator?
#           if !version.nil? && version.event == "create"
#              logger.debug("Findeme approving create: setting approved flag")
#              result = self.update_attributes(:active => 1)
#              version.destroy
#     	     logger.debug("Findeme approving create: after setting approved flag")   
#           end          
#         end
#       end

      def approve_operation
       logger.debug("Findeme User: #{Auditor.whodunnit.username} ")
       if switched_on? && moderator?
      	   # check if a dirty version exists
		  dirty_version =  version
		  result = false
		  if dirty_version != nil	    	 
		     if( dirty_version.event == "destroy" )
		       logger.debug("Findeme in destroy: #{self.to_json} ")
			   result =  self.destroy
   		       logger.debug("Findeme after destroy: #{dirty_version.to_json} ")
		     elsif( dirty_version.event == "update")      
			    obj = dirty_version.reify
     			result = self.update_attributes(obj.attributes)
    	     elsif(dirty_version.event == "create")
    	       logger.debug("Findeme approving create: setting approved flag")
    	       result = self.update_attributes(:active => 1)
    	       logger.debug("Findeme approving create: after setting approved flag")    	       
    	     end
    	  end
    	  dirty_version.destroy if result 
        end
      end
     
      def reject_operation
       logger.debug("Findeme inside reject_operation")
        if switched_on? && moderator?
          dirty_version =  version
          if(!dirty_version.nil?)
            if( dirty_version.event == "create")
              logger.debug("Findeme destroy parent object: #{self.to_json} ")
              self.destroy
            end 
          logger.debug("Findeme destroying audit object: #{dirty_version.to_json} ")
          dirty_version.destroy
          end
        end
      end
      
      
      
      
      private

      def version_class
        version_class_name.constantize
      end
      
      # set active to false before create
      def before_create
	      self.active = 0   
      end
      
      def record_create
        if switched_on? && not_moderator?
          create_version merge_metadata(:event => 'create', 
          				  		        :object    => object_to_string(item_created),
          								:whodunnit => Auditor.whodunnit)              								
        end
      end

      def record_update
        logger.debug("Findeme in update: User= #{Auditor.whodunnit.username}")
        if switched_on? && changed_notably? && not_moderator?
		  #copy the current changed obj
		  changed_obj = self.clone		  
          revert_changes # revert changes to the obj
          # search for exiting record with same model and id
          cur_version = version_class.with_item_keys(self.class.base_class.name, id).first
          cur_version = build_version if cur_version == nil
          cur_version.update_attributes merge_metadata(:event     => 'update',
                                	                   :object    => object_to_string(changed_obj),
                                           		       :whodunnit => Auditor.whodunnit)
        elsif moderator?
          cur_version = version_class.with_item_keys(self.class.base_class.name, id).first
        
        end
      end


      def merge_metadata(data)
        # First we merge the model-level metadata in `meta`.
        meta.each do |k,v|
          data[k] = 
            if v.respond_to?(:call)
              v.call(self)
            elsif v.is_a?(Symbol) && respond_to?(v)
              send(v)
            else
              v
            end
        end
        # Second we merge any extra data from the controller (if available).
        data.merge(Auditor.controller_info || {})
      end
		
	  def item_created
	     self.clone.tap do |item |
	        item.id = id
	     end	     
	  end
	  
	  def revert_changes
	   logger.debug("Findeme - before revert : #{self.to_json} ")
	   changed_attributes.each do |k, v|
         begin
           self.send :write_attribute, k.to_sym , v
         rescue NoMethodError
           logger.warn "Attribute #{k} does not exist on #{item_type} (Version id: #{id})."
         end
        end
        logger.debug("Findeme - after revert : #{self.to_json} ")
	  end
	  
      def item_before_change
        self.clone.tap do |previous|
          previous.id = id
          changed_attributes.each { |attr, before| previous[attr] = before }
        end
      end

      def object_to_string(object)
        object.attributes.to_yaml
      end

      def changed_notably?
        notably_changed.any?
      end

      def notably_changed
        changed - self.class.ignore
      end

      # Returns `true` if Auditor is globally enabled and active for this class,
      # `false` otherwise.
      def switched_on?
        Auditor.enabled? && self.class.auditor_active
      end
      
      # Returns `true` if the current user does not have moderator permission
      # Users with moderator permission can edit /approve 
      def not_moderator?
        !(permitted_to?(:manage, :user => Auditor.whodunnit))
      end
      
      def moderator?
        permitted_to?(:manage, :user => Auditor.whodunnit)
      end
      
    end

  end
end

ActiveRecord::Base.send :include, Auditor::Model



      
      # store or update the audit record for update operation.
#       def log_for_audit
#         logger.debug("Findeme User: #{Auditor.whodunnit} ")
#          if switched_on? && changed_notably?
#            cur_version = Audit.with_item_keys(self.class.base_class.name, id).last
#            cur_version = versions.build if cur_version.nil?
#            cur_version.attributes = merge_metadata(:event     => 'update',
#                                 	               :object    => object_to_string(self.clone),
#                                            		   :whodunnit => Auditor.whodunnit)
#            cur_version.save
#           end   
#       end

#       def record_update
#         if switched_on? && changed_notably?
#           # search for exiting record with same model and id
#           cur_version = version_class.with_item_keys(self.class.base_class.name, id).first
#           cur_version = versions.build if cur_version == nil
#           cur_version.attributes =  merge_metadata(:event     => 'update',
#                                 	               :object    => object_to_string(item_before_change),
#                                            		   :whodunnit => Auditor.whodunnit)
#            
#            cur_version.save # save the audit column
#            return false # dont update the parent                             
#         end
#       end

#       def record_destroy
#         if switched_on? and not new_record?
#           version_class.create merge_metadata(:item      => self,
#                                               :event     => 'destroy',
#                                               :object    => object_to_string(item_before_change),
#                                               :whodunnit => Auditor.whodunnit)
#         end
#       end

#       def record_destroy
#        logger.debug("Findeme in destroy: User= #{Auditor.whodunnit}")
#         if switched_on? and not new_record? && not_moderator?
#    	      cur_version = Audit.with_item_keys(self.class.base_class.name, id).last
# 	      if cur_version.nil?
#             version_class.create merge_metadata(:item      => self,
#                                                 :event     => 'destroy',
#                                                 :object    => object_to_string(item_before_change),
#                                                 :whodunnit => Auditor.whodunnit)
#           else
#             cur_version.update_attributes(:event => 'destroy')
#           end
#           self.attributes = item_before_change.attributes # revert changes on obj
#           logger.debug("Findeme -self : #{self.to_json} ")
#           logger.debug("Findeme - audit : #{cur_version.to_json} ")
#           return false
#         end
#       end

#       def approve_operation(version_id)
#        logger.debug("Findeme User: #{Auditor.whodunnit} ")
#        if switched_on? && moderator?
#       	   # check if a dirty version exists
# 		  dirty_version =  version_class.find(version_id)
# 		  result = false
# 		  if dirty_version != nil	    	 
# 		     if( dirty_version.event == "destroy" )
# 			    result =  self.destroy
# 		     elsif( dirty_version.event == "update")      
# 			    obj = dirty_version.reify
#      			result = self.update_attributes(obj.attributes)
#     	     end
#     	  end
#     	  dirty_version.destroy if result 
#         end
#       end


#       def record_destroy
#        logger.debug("Findeme in destroy: User= #{Auditor.whodunnit}")
#        if switched_on? and not new_record? && not_moderator?
#        self.class.update_all ["updated_at = ?", Time.now]
#    	     cur_version = Audit.with_item_keys(self.class.base_class.name, id).last
# 		 version_class.transaction(:requires_new => true) do
# 	        if cur_version.nil?
#               version_class.create merge_metadata(:item      => self,
#                                                 :event     => 'destroy',
#                                                 :object    => object_to_string(item_before_change),
#                                                 :whodunnit => Auditor.whodunnit)
#             else
#               cur_version.update_attributes(:event => 'destroy')
#             end
#           end
#           #self.attributes = item_before_change.attributes # revert changes on obj
#           logger.debug("Findeme -self : #{self.to_json} ")
#           logger.debug("Findeme - audit : #{cur_version.to_json} ")
#           #return false
#         end
#       end