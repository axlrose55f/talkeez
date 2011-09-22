class AwardsController < ApplicationController
  # select the lay out to use for this controller
  layout :determine_layout
  before_filter :require_user, :only => [:edit, :update, :new, :create ,:destroy]
  
  # GET /awards
  # GET /awards.xml
  def index
    @awardTypes = AwardType.find(:all)
    @top_movies = MovieAward.top_movies(current_user)
    
    @top_artists = MovieAward.top_artists(current_user)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @awardTypes }
    end
  end

  def show
    @year = params[:year] ? "#{params[:year]}-01-01".to_date : Date.today.years_ago(1).beginning_of_year()
    @type = Award.find(:all, :conditions => [" type_id=?",params[:id]])

    a_list = []
    @type.each do |a|
     a_list << a.id 
    end
    @type_name = @type[0].type_name unless @type.empty?
    @type_id = @type[0].type_id unless @type.empty?

    m_awards = MovieAward.find(:all, :conditions => [" award_id in (?) and year = ?", a_list, @year],:include => [:award, :movie, :artist] )

    
    @awards = {}
    @list = []
    if !m_awards.nil? 
      m_awards.each do |a|
       @list << a.award.name
       (@awards[a.award.name] ||= []) << a
      end
    end 
    @list.uniq!
       
    # get the dates for calender
    @cal_width = 31
    cal_center = (@cal_width/2).round
    @cal_end = params[:cal_pos] ? "#{params[:cal_pos]}-01-01".to_date : @year.years_since(cal_center).beginning_of_year()

	if @cal_end.future?
		@cal_end =  Date.today 
    end
    @cal_start = @cal_end.years_ago(@cal_width)
    
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
    @award = MovieAward.find(params[:id])
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
  
    # GET /awards/1
  # GET /awards/1.xml
  def categories
    @awardType = AwardType.find(params[:id])
    @awards = @awardType.awards 

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie_awards }
    end
  end
  
  # Get the layout to use 
  private   
  def determine_layout
	"common"
  end
end
