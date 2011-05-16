class AwardTypesController < ApplicationController
  # select the lay out to use for this controller
  layout :determine_layout
  
  # GET /awards
  # GET /awards.xml
  def index
    @awards = AwardType.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @awards }
    end
  end

  # GET /awards/1
  # GET /awards/1.xml
  def show
    @award = AwardType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @award }
    end
  end

  # GET /awards/new
  # GET /awards/new.xml
  def new
    @award = AwardType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @award }
    end
  end

  # GET /awards/1/edit
  def edit
    @award = AwardType.find(params[:id])
  end

  # POST /awards
  # POST /awards.xml
  def create
    @award = AwardType.new(params[:award_type])

    respond_to do |format|
      if @award.save
        flash[:notice] = 'Award was successfully created.'
        format.html { redirect_to(@award) }
        format.xml  { render :xml => @award, :status => :created, :location => @award }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @award.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /awards/1
  # PUT /awards/1.xml
  def update
    @award = AwardType.find(params[:id])

    respond_to do |format|
      if @award.update_attributes(params[:award_type])
        flash[:notice] = 'Award was successfully updated.'
        format.html { redirect_to(@award) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @award.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /awards/1
  # GET /awards/1.xml
  def showCategories
    @award = AwardType.find(params[:id])
    @award_cat = AwardCategories.find(params[:cat_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @award }
    end
  end

  # DELETE /awards/1
  # DELETE /awards/1.xml
  def destroy
    @award = AwardType.find(params[:id])
    @award.destroy

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
