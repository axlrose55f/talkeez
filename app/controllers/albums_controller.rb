class AlbumsController < ApplicationController
    # select the lay out to use for this controller
  layout :determine_layout
  
  
  # GET /albums
  # GET /albums.xml
  def index
    @albums = Album.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = Album.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /movies/1/tracks
  def tracks
    @album = Album.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /movies/1/artists
  def artists
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end
  
  # GET /movies/1/reviews
  def reviews
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # reviews.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/movies
  def movies
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # awards.html.erb
      format.xml  { render :xml => @album }
    end
  end
    

  
  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = Album.new
    @genres = Genre.find(:all, :order => "name")
    @artists = Artist.find(:all, :order => "name")
    @movies = Movie.find(:all, :order => "name")
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
    @genres = Genre.find(:all, :order => "name")
    @artists = Artist.find(:all, :order => "name")
    @movies = Movie.find(:all, :order => "name")
  end

  # GET /albums/1/edit
  def editgenres
    @album = Album.find(params[:id])
    @genres = Hash.new 
    Genre.find(:all, :order => "name" ).map {|u|  @genres[u.name] = u.id }
  end
  
  # GET /albums/1/edit
  def editartists       
    @album = Album.find(params[:id])
    @artists = Hash.new
    Artist.find(:all, :order => "name" ).map {|u|  @artists[u.name] = u.id }
  end

  
  # GET /albums/1/edit
  def editmovies       
    @album = Album.find(params[:id])
    @movies = Hash.new
    Movie.find(:all, :order => "name" ).map {|u|  @movies[u.name] = u.id }
  end
  
  # POST /albums
  # POST /albums.xml
  def create
 
    @album = Album.new(params[:album])
      
    respond_to do |format|
      if @album.save
        flash[:notice] = 'Album was successfully created.'
        format.html { redirect_to(@album) }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        flash[:notice] = 'Album was successfully updated.'
        format.html { redirect_to(@album) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1/updategenres
   # PUT /albums/1.xml
   def updategenres
     @album = Album.find(params[:id])
     album_param = params[:albums]    
     album_param[:genres].each do |genre_id|
         genre = Genre.find(genre_id)
         @album.genres << genre       
     end    
     respond_to do |format|
      format.html { redirect_to(@album) }
      format.xml  { head :ok }
     end    
   end

   # PUT /albums/1/updategenres
   # PUT /albums/1.xml
   def updateartists
     @album = Album.find(params[:id])
     album_param = params[:albums]
     @album.artists.delete_all       
     album_param[:artists].each do |artist_id|
         artist = Artist.find(artist_id)
         @album.artists << artist        
     end    
     respond_to do |format|
      format.html { redirect_to(:action => :show) }
      format.xml  { head :ok }
     end    
   end

   
   
   # PUT /albums/1/updatemovies
   # PUT /albums/1.xml
   def updatemovies
     @album = Album.find(params[:id])
     album_param = params[:albums]  
     @album.movies.delete_all 
     album_param[:movies].each do |movie_id|
         movie = Movie.find(movie_id)
         @album.movies << movie        
     end    
     respond_to do |format|
      format.html { redirect_to(:action => :awards) }
      format.xml  { head :ok }
     end    
   end
   
  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to(albums_url) }
      format.xml  { head :ok }
    end
  end
  
    # Get the layout to use 
  private   
  def determine_layout
	"common"
  end
  
end
