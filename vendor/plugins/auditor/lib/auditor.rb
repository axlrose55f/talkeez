require 'singleton'
require 'yaml'

require 'action_controller'
require 'active_record'

require 'auditor/config'
require 'auditor/controller'
require 'auditor/has_auditor'
require 'auditor/version'


# Auditor's module methods can be called in both models and controllers.
module Auditor

  # Switches Auditor on or off.
  def self.enabled=(value)
    Auditor.config.enabled = value
  end

  # Returns `true` if Auditor is on, `false` otherwise.
  # Auditor is enabled by default.
  def self.enabled?
    !!Auditor.config.enabled
  end


  # Returns who is reponsible for any changes that occur.
  def self.whodunnit
    auditor_store[:whodunnit]
  end

  # Sets who is responsible for any changes that occur.
  # You would normally use this in a migration or on the console,
  # when working with models directly.  In a controller it is set
  # automatically to the `current_user`.
  def self.whodunnit=(value)
    auditor_store[:whodunnit] = value
  end

  # Returns any information from the controller that you want
  # Auditor to store.
  #
  # See `Auditor::Controller#info_for_auditor`.
  def self.controller_info
    auditor_store[:controller_info]
  end

  # Sets any information from the controller that you want Auditor
  # to store.  By default this is set automatically by a before filter.
  def self.controller_info=(value)
    auditor_store[:controller_info] = value
  end


  private

  # Thread-safe hash to hold Auditor's data.
  def self.auditor_store
    Thread.current[:auditor] ||= {}
  end

  # Returns Auditor's configuration object.
  def self.config
    @@config ||= Auditor::Config.instance
  end

end
