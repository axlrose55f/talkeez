class JavascriptsController < ApplicationController
  def dynamic_roles
  	@roles = Role.find(:all)
  end
end
