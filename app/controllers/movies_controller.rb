class MoviesController < ApplicationController
  # select the lay out to use for this controller
  layout :determine_layout
  before_filter :require_user, :only => [:edit, :update, :new, :create ,:destroy, :updateartists, :addCastDetail, :deleteCastDetail, :updateawards, :deleteAward, :addAward, :deleteGenre, :addGenre, :updategenres  ]
  
  # GET /movies
  # GET /movies.js
  def index
   
   @movies = Movie.active.rated.limit(10).order
   @latest_movies = Movie.active.latest.limit(6).order('year DESC')
   @recently_edited =  Movie.active.limit(5).order('updated_at DESC')
   @top_this_year = Movie.active.latest.limit(10).order
   @top_decade = Movie.active.after(Date.today.years_ago(10)).limit(10).order
   @recently_added = Movie.added(6)
   @genres = Genre.find(:all)
   @recent_rated = Rate.latest(8)
   
   # recent review
   #@recent_reviews = Review.latest.limit
   # recent rated   
   #@movies = Movie.find(:all, :limit => 4, :conditions => 'rating > 4', :order => 'rating DESC')   
   #@latest_movies = Movie.find(:all, :limit => 6, :conditions => ['rating > 3 and year between ? and ?', Date.today.beginning_of_year(), Date.today], :order => 'rating DESC, year DESC')
   #@recently_edited =  Movie.find(:all, :limit => 4, :order => 'updated_at DESC')
   #@top_all = Movie.find(:all, :limit => 10, :conditions => 'rating > 4', :order => 'rating DESC')
   #@top_this_year = Movie.find(:all, :limit => 10, :conditions => ['year > ?', Date.today.beginning_of_year()], :order => 'rating DESC')
   #@top_decade = Movie.find(:all, :limit => 10, :conditions => ['year > ?', Date.today.years_ago(10)],  :order => 'rating DESC')
  end
  
  # GET /movies
  # GET /movies.js
  def search
   @search_param = params[:search]? params[:search]: nil  	 
   @search_param = ( params[:movie]? params[:movie][:name]: nil) unless (@search_param != nil && !@search_param.empty?) 
   @movies = Movie.search(@search_param, params[:page])
   respond_to do |format|
      format.html # show.html.erb
      format.js  { 
      layout = nil 
        render :js => @movie 
      }
   end
  end
  
  def list
  list_type = params[:type]
  
    if list_type == "rated"  
      @movies = Movie.active.rated(3).order('rating DESC, year DESC').limit(100).paginate(:page => params[:page])  
    elsif list_type == "latest"  
      @movies = Movie.recent(50).paginate(:page => params[:page], :per_page => 10)
    elsif list_type == "updated"  
      @movies = Movie.updated(50).paginate(:page => params[:page], :per_page => 10)
    elsif list_type == "r_rated"  
      @movies = Rate.latest(50).paginate(:page => params[:page], :per_page => 10)
    elsif list_type == "added"  
      @movies = Movie.added(50).paginate(:page => params[:page], :per_page => 10)  
    end
    
  end
    
  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.show_data(params[:id],current_user) 
    @genres = @movie.active_genres(current_user)
    @videos = @movie.active_videos(current_user)
    @cast_list = @movie.active_artists_leads(current_user)
    @awards = @movie.active_awards(current_user)
  
    @total_percentage_like = rate_percentage("like")
    #logger.debug "FindMe Im in total percentage #{@total_percentage_like}"
    
    # @total_percentage_hate = rate_percentage("hate")
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/showcast
  def showcast
    @movie = Movie.find(params[:id]) 
    @genres = @movie.active_genres(current_user)
    
    @casts = @movie.show_artists(current_user,['cast'])
    @crews = @movie.show_artists(current_user,['crew','ProductionCrew'])
    @total_percentage_like = rate_percentage("like")
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/reviews
  def reviews
    @movie = Movie.find(params[:id])
    @genres = @movie.active_genres(current_user)
    @total_percentage_like = rate_percentage("like")
    respond_to do |format|
      format.html # reviews.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/awards
  def awards
    @movie = Movie.find(params[:id])
    @genres = @movie.active_genres(current_user)
    @total_percentage_like = rate_percentage("like")
    
    m_awards = @movie.active_awards(current_user)
    @awards = {}
    if !m_awards.nil? 
      m_awards.each do |a|
       (@awards[a.type_name] ||= []) << a
      end
    end    
    respond_to do |format|
      format.html # awards.html.erb
      format.xml  { render :xml => @movie }
    end
  end
    
  # GET /movies/1/videos
  def videos
    @movie = Movie.find(params[:id])
    @genres = @movie.active_genres(current_user)
 	  @videos = @movie.active_videos(current_user)
 	  @total_percentage_like = rate_percentage("like")
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
    # If the data has been modified already, show the modified version
    @movie = @movie.version.reify  unless @movie.live?
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
  

  #### Handle Genres  #####
  

  
    # GET /movies/1/edit
  def editgenres
    @movie = Movie.find(params[:id])   
    # @genres = Hash.new 
    #    Genre.find(:all, :order => "name" ).map {|u|  @genres[u.name] = u.id }
    @genres = Genre.find(:all, :order => "name" )
  end
  

  
  #### Add Video ####
  def addVideo
    @movie = Movie.find(params[:id])
    video_url = params[:movie][:video_url]
    if(video_url != nil)
      video = Video.create_with_url(video_url)
      begin      
      	@movie.videos << video
      rescue Exception => e
       if e.is_a? ActiveRecord::StatementInvalid
         logger.debug("trying to add duplicate entry")
       end
      end
    end  
    redirect_to(:action => :videos)
  end
  
  #### Delete Video ###
  def deleteVideo
      movie_id = params[:id]
      video_id = params[:video_id]
      @movie_video = VideoAttachment.find(:first, :conditions => [ "videoable_id = ? and video_id = ?",movie_id,video_id])
      @movie_video.destroy
      redirect_to movie_path(:id => movie_id)
  end
  
  
  ###### Edit Reviews #####
  def editreviews
    @movie = Movie.find(params[:id])
    @genres = @movie.active_genres(current_user)
    @review = if(params[:rev]) 
       Review.find(params[:rev]) 
     else
       Review.new
     end
  end
  
  def addReview
    @movie = Movie.find(params[:id])
    if(params[:movie][:review_id]) 
      review = Review.find(params[:movie][:review_id])
      review.title = params[:movie][:review_title]
      review.text = params[:movie][:review_text]      
      review.save
    else 
        @movie.review(params[:movie][:review_title],params[:movie][:review_text], current_user)
    end
    respond_to do |format|
     format.html { redirect_to(:action => 'reviews' ) }
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
    @movie.log_destroy_for_audit
    flash[:notice] = "Your requests for deletion of #{@movie.name} was successfully submitted."
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
    rates = @movie.rates
    for r in rates
     if r.stars > min && r.stars < max 
      num_rates_above = num_rates_above + 1
     end
    end 
    total_percentage = (100 * num_rates_above)/ total
   end 
end




######## unused ############

  #### Handle Artists  #####
  
    # GET /movies/1/edit
#   def editartists       
#     @movie = Movie.find(params[:id])   
#     #@artists = Artist.find(:all, :order => "name" )
#     type = params[:type]
#     @roles = Role.find(:all, :conditions => ['role_type = ?', type], :order => "name")
#     
#     if type == 'cast'
#      @artist_roles = @movie.cast.cast_list(@movie.id)
#     else
#      @artist_roles = @movie.cast.crew_list(@movie.id)
#     end
#     # @artists = Hash.new 
#     # @roles = Hash.new   
#     # Artist.find(:all, :order => "name" ).map {|u|  @artists[u.name] = u.id }
#     # Role.find(:all, :order => "name").map {|u| @roles[u.name] = u.id}
#   end
  
  # PUT /movies/1/updategenres
  # PUT /movies/1.xml
#   def updateartists
#     @movie = Movie.find(params[:id])
#     movie_param = params[:movies]
#     @selected_artists = Array.new
#     movie_param[:artist_ids].each do |artist_id|       
#          @selected_artists << Artist.find(artist_id)       
#     end
#      @movie.artists = @selected_artists            
#     respond_to do |format|
#      format.html { redirect_to(:action => :showcast) }
#      format.xml  { head :ok }
#     end    
#   end
  
  # PUT /movies/1/updategenres
  # PUT /movies/1.xml
#   def addCastDetail
#     @movie = Movie.find(params[:id])
#     @artist = Artist.find_by_name(params[:movie][:artist_name])
#     @role = Role.find(params[:movie][:roles])
#     movie_role = MovieRole.new
#     movie_role.movie = @movie
#     movie_role.artist = @artist
#     movie_role.role = @role
#     if movie_role.save    
#       redirect_to(:action => :showcast)
#     else
#       render :action => "editartists"       
#     end     
#   end
  
 
  # DELETE /movies/1/deleteCastDetail
  # DELETE /movies/1.xml
#   def deleteCastDetail
#     @movie = Movie.find(params[:id])
#     movie_role = MovieRole.find(params[:mar_id])
#     movie_role.destroy 
#     redirect_to(:action => :showcast)
#         
#   end

   # PUT /movies/1/addGenre
  # PUT /movies/1.xml
#   def addGenre
#     @movie = Movie.find(params[:id])
#     @genre = Genre.find(params[:movie][:genres])
#     @movie.genres << @genre
#     respond_to do |format|
#      format.html { redirect_to(@movie) }
#      format.xml  { head :ok }
#     end     
#   end
  
  # DELETE /movies/1/deleteGenre
  # DELETE /movies/1.xml
#   def deleteGenre
#     @movie = Movie.find(params[:id])
#     @movie.genres.delete(Genre.find(params[:genre_id]))
#     respond_to do |format|
#      format.html { redirect_to(@movie) }
#      format.xml  { head :ok }
#     end         
#   end
  
  # PUT /movies/1/updategenres
  # PUT /movies/1.xml
#   def updategenres
#     @movie = Movie.find(params[:id])    
#     @selected_genres = Array.new   
#     movie_param = params[:movies]  
#     # logger.debug ("FindMe I'm in genre update #{movie_param[:genre_ids].length}")
#     movie_param[:genre_ids].each do |genre_id|       
#         @selected_genres << Genre.find(genre_id)
#     end    
#     @movie.genres = @selected_genres    
#     respond_to do |format|
#      format.html { redirect_to(@movie) }
#      format.xml  { head :ok }
#     end    
#   end



