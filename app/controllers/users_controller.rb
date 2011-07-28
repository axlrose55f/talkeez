class UsersController < ApplicationController
  # select the lay out to use for this controller
  filter_resource_access
  before_filter :require_user, :only => [:show, :edit, :update]
  layout :determine_layout
  
  # GET /users
   # GET /users.xml
   def accounts
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
    respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @user }
     end
  end
  
  def edit
    @user = User.find(params[:id], :include => [{:roles => :role }])
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id], :include => [{:roles => :role }])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  
  # POST /user
  # POST /user.xml
  def create
    @user = User.new(params[:user])
    if @user.save 
        # flash[:notice] = 'Successfully registered user!'
        # seed it with User role.
         UserRole.create(:user => @user, :role => UserRoleTypes.find(2))
         redirect_to(@user)        
       else
        render :action => "new"               
      end
  end
  
  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save  
       # flash[:notice] = 'Successfully updated user!'
	   redirect_to(@user)
     else
      render :action => 'edit'
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
  
  def reviews
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # reviews.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def videos
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # reviews.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def movies
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # reviews.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
   def artists
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # reviews.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def friends
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # reviews.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def audits  
	  @audits = Audit.find(:all)  
  end
  
  def addRole
    @user = User.find(params[:id])
    @role = UserRoleTypes.find(params[:user][:roles])
    user_role = UserRole.new(:user => @user, :role => @role)
    if user_role.save
       redirect_to(@user) 
    else
       render :action => :edit
    end     
  end
  
  def deleteRole
    @user = User.find(params[:id])
    @role = UserRole.find(params[:role_id])
    if @role.destroy
      redirect_to(@user)
    else  
      render :action => :edit
    end         
  end
  
    # Get the layout to use 
  private   
  def determine_layout
	"common"
  end
  
end
