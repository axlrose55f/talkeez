class MovieGenresController < ApplicationController
  before_filter :require_user, :only => [:edit, :update, :new, :create ,:destroy] 
     
  def new 
   @movie_genre = MovieGenre.new
   @movie = Movie.find(params[:movie_id])
   @movie_genres = @movie.active_genres(current_user)
   @genres = Genre.find(:all, :order => "name" )
  end
  
  def edit
   @movie = Movie.find(params[:id])
   @genres = Genre.find(:all, :order => "name" )
  end
  
  def destroy
    movie_id = params[:movie_id]
    genre_id = params[:id]
    @movie_genre = MovieGenre.find(:first, :conditions => [ "movie_id = ? and genre_id = ?",movie_id, genre_id ])
    @movie_genre.log_destroy_for_audit
    #flash[:notice] = "Your requests for deletion of genre was successfully submitted."
    redirect_to movie_path(:id => params[:movie_id])  
  end
  
  def create
     begin      
		MovieGenre.create(params[:movie_genre])
		#flash[:notice] = "Your requests to add genre was successfully submitted."
     rescue Exception => e
       if e.is_a? ActiveRecord::StatementInvalid
         flash[:notice] = "This genre is already added."
       end
     end
    redirect_to movie_path(:id => params[:movie_genre][:movie_id])  
  end
  
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

end