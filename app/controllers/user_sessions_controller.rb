class UserSessionsController < ApplicationController
   before_filter :require_no_user, :only => [:new, :create]
   before_filter :require_user, :only => :destroy
   layout :determine_layout
  
   def new
     @user_session = UserSession.new
   end

   def create
     @user_session = UserSession.new(params[:user_session])
     if @user_session.save do | result|
      if result         
         # flash[:notice] = "Login successful!"
          redirect_to root_url
      else
        render :action => :new
      end
    end
   end    
  end

   def destroy
     current_user_session.destroy
   #  flash[:notice] = "Logout successful!"
     redirect_to root_url
   end
   
  # Get the layout to use 
  private   
  def determine_layout
	"common"
  end

end
