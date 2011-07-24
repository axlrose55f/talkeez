module Auditor
  class Config
    include Singleton
    attr_accessor :enabled
 
    def initialize
      # Indicates whether Auditor is on or off.
      @enabled = true
    end
  end
end
