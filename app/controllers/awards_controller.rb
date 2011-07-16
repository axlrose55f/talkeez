class AwardsController < ApplicationController
  # select the lay out to use for this controller
  layout :determine_layout
  before_filter :require_user
  
  # GET /awards
  # GET /awards.xml
  def index
    @awards = MovieAward.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @awards }
    end
  end

  # GET /awards/1
  # GET /awards/1.xml
  def show   
    @category = AwardCategories.find(params[:id])
    @awards = MovieAward.find(:all, :conditions => [ "award_id = ?", params[:id]])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @award }
    end
  end

  # GET /awards/new
  # GET /awards/new.xml
  def new	
	@award = MovieAward.new()
    @movie_id = params[:movie]
    @artist_id = params[:artist]
    @award_cat_id = params[:award_cat]
    @year = params[:year] ?params[:year] : "1900"  

    logger.info 'FINDME message'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @award }
    end
  end

  # GET /awards/1/edit
  def edit
    @award = Award.find(params[:id])
  end

  # POST /awards
  # POST /awards.xml
  def create
    @movie = Movie.find(params[:movie_award][:movie])
    @award = MovieAward.new(:movie => @movie,
    	                   :artist => Artist.find(params[:movie_award][:artist]),
    	                   :categories => AwardCategories.find(params[:movie_award][:id]),
    	                   :year => Date.strptime(params[:movie_award]['year(1i)'],'%Y'))
    
    respond_to do |format|
      if @award.save
       # flash[:notice] = 'Award was successfully created.'
        format.html { redirect_to(@movie) }
        format.xml  { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @award.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /awards/1
  # PUT /awards/1.xml
  def update
    @award = Award.find(params[:id])

    respond_to do |format|
      if @award.update_attributes(params[:award])
       # flash[:notice] = 'Award was successfully updated.'
        format.html { redirect_to(@award) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @award.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /awards/1
  # DELETE /awards/1.xml
  def destroy
    @award = Award.find(params[:id])
    @award.destroy

    respond_to do |format|
      format.html { redirect_to(awards_url) }
      format.xml  { head :ok }
    end
  end
  
      # Get the layout to use 
  private   
  def determine_layout
	"common"
  end
end
