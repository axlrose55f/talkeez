module Auditor
  module Controller

    def self.included(base)
      base.before_filter :set_auditor_whodunnit
      base.before_filter :set_auditor_controller_info
    end

    protected

    # Returns the user who is responsible for any changes that occur.
    # By default this calls `current_user` and returns the result.
    # 
    # Override this method in your controller to call a different
    # method, e.g. `current_person`, or anything you like.
    def user_for_auditor
      current_user rescue nil
    end

    # Returns any information about the controller or request that you
    # want Auditor to store alongside any changes that occur.  By
    # default this returns an empty hash.
    #
    # Override this method in your controller to return a hash of any
    # information you need.  The hash's keys must correspond to columns
    # in your `versions` table, so don't forget to add any new columns
    # you need.
    #
    # For example:
    #
    #     {:ip => request.remote_ip, :user_agent => request.user_agent}
    #
    # The columns `ip` and `user_agent` must exist in your `versions` # table.
    #
    # Use the `:meta` option to `Auditor::Model::ClassMethods.has_auditor`
    # to store any extra model-level data you need.
    def info_for_auditor
      {}
    end

    private

    # Tells Auditor who is responsible for any changes that occur.
    def set_auditor_whodunnit
      ::Auditor.whodunnit = user_for_auditor
    end

    # DEPRECATED: please use `set_auditor_whodunnit` instead.
    def set_whodunnit
      logger.warn '[Auditor]: the `set_whodunnit` controller method has been deprecated.  Please rename to `set_auditor_whodunnit`.'
      set_auditor_whodunnit
    end

    # Tells Auditor any information from the controller you want
    # to store alongside any changes that occur.
    def set_auditor_controller_info
      ::Auditor.controller_info = info_for_auditor
    end

  end
end

ActionController::Base.send :include, Auditor::Controller
