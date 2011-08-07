class AwardTypesController < ApplicationController
  # select the lay out to use for this controller
  layout :determine_layout
  before_filter :require_user, :only => [:edit, :update, :new, :create ,:destroy]
  
  # GET /awards
  # GET /awards.xml
  def index
    @awardTypes = AwardType.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @awardTypes }
    end
  end

  # GET /awards/1
  # GET /awards/1.xml
  def show
    @awardType = AwardType.find(params[:id])
    @awards = @awardType.awards

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @awardType }
    end
  end

  # GET /awards/new
  # GET /awards/new.xml
  def new
    @awardType = AwardType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @awardType }
    end
  end

  # GET /awards/1/edit
  def edit
    @awardType = AwardType.find(params[:id])
  end

  # POST /awards
  # POST /awards.xml
  def create
    @awardType = AwardType.new(params[:award_type])
    respond_to do |format|
      if @awardType.save
        #flash[:notice] = 'Award Type was successfully created.'
        format.html { redirect_to(@awardType) }
        format.xml  { render :xml => @awardType, :status => :created, :location => @awardType }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @awardType.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /awards/1
  # PUT /awards/1.xml
  def update
    @awardType = AwardType.find(params[:id])
    respond_to do |format|
      if @awardType.update_attributes(params[:award_type])
       # flash[:notice] = 'Award Type was successfully updated.'
        format.html { redirect_to(@awardType) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @awardType.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /awards/1
  # GET /awards/1.xml
  def showCategories
    @award = Award.find(params[:award_id])
    @movie_awards = @award.movie_awards    

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie_awards }
    end
  end

  # DELETE /awards/1
  # DELETE /awards/1.xml
  def destroy
    @awardType = AwardType.find(params[:id])
    @awardType.destroy

    respond_to do |format|
      format.html { redirect_to(award_types_url) }
      format.xml  { head :ok }
    end
  end
  
      # Get the layout to use 
  private   
  def determine_layout
	"common"
  end
end
