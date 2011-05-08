class UsersController < ApplicationController
  before_filter :require_user, :only => [:show, :edit, :update]
  
  # GET /users
   # GET /users.xml
   def index
     @users = User.find(:all)

     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @users }
     end
   end
  
  # GET /user/new
  # GET /user/new.xml
  def new
    @user = User.new
  end
  
  def edit
    @user = current_user
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show
    @user = current_user
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  
  # POST /user
  # POST /user.xml
  def create
    @user = User.new(params[:user])
    @user.save do | result |
      if result 
         flash[:notice] = 'Successfully registered user!'
         redirect_to(@user)        
       else
        render :action => "new"               
      end
    end  
  end
  
  def update
    @user = current_user
    @user.attributes = params[:user]
    @user.save do |result |
     if result  
      flash[:notice] = 'Successfully updated user!'
      redirect_to users_url
     else
      render :action => 'edit'
     end    
    end       
  end
  
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end  
  
end
