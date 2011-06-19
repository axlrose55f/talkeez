class MoviesController < ApplicationController
  # select the lay out to use for this controller
  layout :determine_layout
  before_filter :require_user, :only => [:edit, :update, :new, :create ,:destroy, :updateartists, :addCastDetail, :deleteCastDetail, :updateawards, :deleteAward, :addAward, :deleteGenre, :addGenre, :updategenres  ]
  auto_complete_for :movie, :name
  
  # GET /movies
  # GET /movies.xml
  def index
   search_param = params[:movie]? params[:movie][:name]: ""  
   @movies = Movie.search(search_param, params[:page])
  end
  
  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id])
    @total_percentage_like = rate_percentage("like")
    @total_percentage_hate = rate_percentage("hate")
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/showcast
  def showcast
    @movie = Movie.find(params[:id])    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/reviews
  def reviews
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html # reviews.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/awards
  def awards
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html # awards.html.erb
      format.xml  { render :xml => @movie }
    end
  end
    
  # GET /movies/1/videos
  def videos
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html # videos.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Movie.new
    @genres = Genre.find(:all, :order => "name")
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])   
  end

  
  # POST /movies
  # POST /movies.xml
  def create
    @movie = Movie.new(params[:movie])

    respond_to do |format|
      if @movie.save
        flash[:notice] = 'Movie was successfully created.'
        format.html { redirect_to(@movie) }
        format.xml  { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end



  
  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Movie.find(params[:id])
   STDERR.puts("\nI'm in update\n ")
    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        #flash[:notice] = 'Movie was successfully updated.'
        
        format.html { redirect_to(@movie) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  ## Movie rating 
  def rate
    @moive = Movie.find(params[:id])
    @moive.rate(params[:stars], current_user, params[:dimension])
    render :update do |page|
      page.replace_html @moive.wrapper_dom_id(params), ratings_for(@moive, params.merge(:wrap => false))
      page.visual_effect :highlight, @moive.wrapper_dom_id(params)
    end
  end
  

  #### Handle Artists  #####
  
    # GET /movies/1/edit
  def editartists       
    @movie = Movie.find(params[:id])   
    @artists = Artist.find(:all, :order => "name" )
    type = params[:type]
    @roles = Role.find(:all, :conditions => ['role_type = ?', type], :order => "name")
    
    if type == 'cast'
     @artist_roles = @movie.cast.cast_list(@movie.id)
    else
     @artist_roles = @movie.cast.crew_list(@movie.id)
    end
    # @artists = Hash.new 
    # @roles = Hash.new   
    # Artist.find(:all, :order => "name" ).map {|u|  @artists[u.name] = u.id }
    # Role.find(:all, :order => "name").map {|u| @roles[u.name] = u.id}
  end
  
  # PUT /movies/1/updategenres
  # PUT /movies/1.xml
  def updateartists
    @movie = Movie.find(params[:id])
    movie_param = params[:movies]
    @selected_artists = Array.new
    movie_param[:artist_ids].each do |artist_id|       
         @selected_artists << Artist.find(artist_id)       
    end
     @movie.artists = @selected_artists            
    respond_to do |format|
     format.html { redirect_to(:action => :showcast) }
     format.xml  { head :ok }
    end    
  end
  
  # PUT /movies/1/updategenres
  # PUT /movies/1.xml
  def addCastDetail
    @movie = Movie.find(params[:id])
    @artist = Artist.find(params[:movie][:artists])
    @role = Role.find(params[:movie][:roles])
    movie_role = MovieRole.new
    movie_role.movie = @movie
    movie_role.artist = @artist
    movie_role.role = @role
    if movie_role.save    
      redirect_to(:action => :showcast)
    else
      render :action => "editartists"       
    end     
  end
  
 
  # DELETE /movies/1/deleteCastDetail
  # DELETE /movies/1.xml
  def deleteCastDetail
    @movie = Movie.find(params[:id])
    movie_role = MovieRole.find(params[:mar_id])
    movie_role.destroy 
    redirect_to(:action => :showcast)
        
  end

  #### Handle Genres  #####
  
  # PUT /movies/1/addGenre
  # PUT /movies/1.xml
  def addGenre
    @movie = Movie.find(params[:id])
    @genre = Genre.find(params[:movie][:genres])
    @movie.genres << @genre
    respond_to do |format|
     format.html { redirect_to(@movie) }
     format.xml  { head :ok }
    end     
  end
  
    # GET /movies/1/edit
  def editgenres
    @movie = Movie.find(params[:id])
    # @genres = Hash.new 
    #    Genre.find(:all, :order => "name" ).map {|u|  @genres[u.name] = u.id }
    @genres = Genre.find(:all, :order => "name" )
  end
  
    # PUT /movies/1/updategenres
  # PUT /movies/1.xml
  def updategenres
    @movie = Movie.find(params[:id])    
    @selected_genres = Array.new   
    movie_param = params[:movies]  
    # logger.debug ("FindMe I'm in genre update #{movie_param[:genre_ids].length}")
    movie_param[:genre_ids].each do |genre_id|       
        @selected_genres << Genre.find(genre_id)
    end    
    @movie.genres = @selected_genres    
    respond_to do |format|
     format.html { redirect_to(@movie) }
     format.xml  { head :ok }
    end    
  end
  
  # DELETE /movies/1/deleteGenre
  # DELETE /movies/1.xml
  def deleteGenre
    @movie = Movie.find(params[:id])
    @movie.genres.delete(Genre.find(params[:genre_id]))
    respond_to do |format|
     format.html { redirect_to(@movie) }
     format.xml  { head :ok }
    end         
  end
  
  #### Handle Awards ####
  
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
  
  
  # GET /movies/1/edit
  def editawards       
    @movie = Movie.find(params[:id])      
   # @awardsCategories = AwardCategories.find(:all, :order => "name" , :include => :award_type )
  end

  # GET /movies/1/edit
  def deleteAward       
    @movie = Movie.find(params[:id])      
    @award = MovieAward.find(params[:award_id] )
    @award.destroy
    respond_to do |format|
     format.html { redirect_to(@movie) }
     format.xml  { head :ok }
    end 
  end
  
  # PUT /movies/1/updateawards
  # PUT /movies/1.xml
  def updateawards
    @movie = Movie.find(params[:id])
    movie_param = params[:movies]  
    @selected_awards = Array.new
    movie_param[:award_ids].each do |award_id|     
         @selected_awards << Award.find(award_id)              
    end   
     @movie.awards =  @selected_awards  
    respond_to do |format|
     format.html { redirect_to(:action => :awards) }
     format.xml  { head :ok }
    end    
  end
  
  # DELETE /movies/1
  # DELETE /movies/1.xml
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to(movies_url) }
      format.xml  { head :ok }
    end
  end

  # Get the layout to use 
private   
  def determine_layout
	"common"
  end

  # find info about rates    
   def rate_percentage(like)
    min = 0
    max = 3.5
    if(like == 'like')
      min = 3.5
      max = 5.1
    end
    total = @movie.total_rates
    return 0 if ! (total > 0) 
    num_rates_above = 0
    for r in @movie.rates
     if r.stars > min && r.stars < max 
      num_rates_above = num_rates_above + 1
     end
    end 
    total_percentage = (100 * num_rates_above)/ @movie.total_rates
   end 
end
