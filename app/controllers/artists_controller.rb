class ArtistsController < ApplicationController
  # select the lay out to use for this controller
  layout :determine_layout
  
  
  # GET /artists
  # GET /artists.xml
  def index
    @artists = Artist.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @artists }
    end
  end

  # GET /artists/1
  # GET /artists/1.xml
  def show
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @artist }
    end
  end

  # GET /artists/1/filmography
  # GET /artists/1.xml
  def filmography
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @artist }
    end
  end
  
  # GET /artists/1/videos
  # GET /artists/1.xml
  def videos
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @artist }
    end
  end
  
  # GET /artists/1/awards
  # GET /artists/1.xml
  def awards
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @artist }
    end
  end
  
  # GET /artists/1/reviews
  # GET /artists/1.xml
  def reviews
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @artist }
    end
  end


  # GET /artists/new
  # GET /artists/new.xml
  def new
    @artist = Artist.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @artist }
    end
  end

  # GET /artists/1/edit
  def edit
    @artist = Artist.find(params[:id])
  end

  # POST /artists
  # POST /artists.xml
  def create
    @artist = Artist.new(params[:artist])

    respond_to do |format|
      if @artist.save
        flash[:notice] = 'Artist was successfully created.'
        format.html { redirect_to(@artist) }
        format.xml  { render :xml => @artist, :status => :created, :location => @artist }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @artist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /artists/1
  # PUT /artists/1.xml
  def update
    @artist = Artist.find(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        
        format.html { redirect_to(@artist) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @artist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.xml
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to(artists_url) }
      format.xml  { head :ok }
    end
  end
  
  ### Rating 
  def rate
    @artist = Artist.find(params[:id])
    @artist.rate(params[:stars], current_user, params[:dimension])
    render :update do |page|
      page.replace_html @artist.wrapper_dom_id(params), ratings_for(@artist, params.merge(:wrap => false))
      page.visual_effect :highlight, @artist.wrapper_dom_id(params)
    end
  end
  
  
  
  ######## Movies ##############
   
  def editmovies       
    @artist = Artist.find(params[:id])  
    
    @movies = Movie.find(:all, :order => "name" )
    @roles = Role.find(:all, :order => "name")
    # @artists = Hash.new 
    # @roles = Hash.new   
    # Artist.find(:all, :order => "name" ).map {|u|  @artists[u.name] = u.id }
    # Role.find(:all, :order => "name").map {|u| @roles[u.name] = u.id}
  end
  
    # PUT /movies/1/updategenres
  # PUT /movies/1.xml
  def addCastDetail
    @artist = Artist.find(params[:id])
    @movie = Movie.find(params[:artist][:movies])
    @role = Role.find(params[:artist][:roles])
    movie_role = MovieRole.new
    movie_role.movie = @movie
    movie_role.artist = @artist
    movie_role.role = @role
    if movie_role.save    
      redirect_to(:action => :filmography)
    else
      render :action => "editmovies"       
    end     
  end
  ########### Awards ###########
    # GET /movies/1/edit
  def editawards       
    @artist = Artist.find(params[:id])
    
  end
  
   # PUT /movies/1/addAward
  def addAward
    award_cat = AwardCategories.find(params[:movie_award][:id])
    artist = Artist.find(params[:movie_award][:artist])
    movie = Movie.find(params[:movie_award][:movie])    
    award = MovieAward.new(:movie => movie,
    	                   :artist => artist,
    	                   :categories => award_cat,
    	                   :year => Date.strptime(params[:movie_award]['year(1i)'],'%Y'),
    	                   :location => params[:movie_award][:location] )
    award.save
    respond_to do |format|
     format.html { redirect_to(movie) }
     format.xml  { head :ok }
    end     
  end
  
  
    # Get the layout to use 
  private   
  def determine_layout
	"common"
  end
end
