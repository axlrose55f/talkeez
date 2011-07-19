class MovieRolesController < ApplicationController
   before_filter :require_user, :only => [:edit, :update, :new, :create ,:destroy, :editArtistRole] 
  
  def edit
  	  @mar = MovieRole.find(params[:id])
  	  @movie = @mar.movie
	  @artist = @mar.artist
	  role = @mar.role
	  @roles = Role.find(:all, :conditions => ['role_type = ?', role.role_type], :order => "name")
	  @num = params["num"]
	  @origin = params["origin"]
  end
 
 def new	  
	  @mar = MovieRole.new
	  @movie = Movie.find(params[:movie_id]) unless params[:movie_id] == nil
	  @artist = Artist.find(params[:artist_id]) unless params[:artist_id] == nil
	  @div_name = params["div_name"]
  end

  def show
	  @mar = MovieRole.find(params[:id])
	  @movie = @mar.movie
	  @artist = @mar.artist
	  @role = @mar.role
  end
  
  def destroy
    @mar = MovieRole.find(params[:id])
    artist_id = @mar.artist.id
    @mar.delete
    redirect_to filmography_artist_path(:id => artist_id)  
  end
  
  def create    
     movie_id = params[:movie_role][:movie_id]
     artist_id = params[:movie_role][:artist_id]
     role_id = params[:movie_role][:role_id]
    
    if(params[:movie_role][:movie_name] != nil )
      movie = Movie.find_by_name(params[:movie_role][:movie_name])
      movie_id = movie.id unless movie == nil
    end
    
    if(params[:movie_role][:artist_name] != nil )
      artist = Artist.find_by_name(params[:movie_role][:artist_name])
      artist_id = artist.id unless artist == nil
    end  
    
    
    if(artist_id != nil && movie_id != nil && role_id != nil)
       MovieRole.create(:movie_id => movie_id,:artist_id => artist_id,:role_id => role_id )  
    end
    
    if(movie != nil)
       redirect_to filmography_artist_path(:id => artist_id)
    elsif (artist != nil)
       redirect_to editartists_movie_path(:id => movie_id)	 
    end
    
  end
  
  def editArtistRole
   @mar = MovieRole.find(params[:id])   
   render :partial => "editArtistRole" , :object => @mar
  end

  def update
	  @mar = MovieRole.find(params[:id])
	  @artist = @mar.artist
	  @movie = @mar.movie
	  origin = params[:movie_role][:origin]	  
	  @mar.update_attributes(params[:movie_role])
	  if origin == "artist"
	  	 redirect_to filmography_artist_path(@artist)	  
	  else
	     redirect_to showcast_movie_path(@movie)
	  end   
  end

end
