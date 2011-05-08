class TracksController < ApplicationController
 
 before_filter :find_album
 
  # GET /tracks
  # GET /tracks.xml
  def index
    @tracks = Track.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tracks }
    end
  end

  # GET /tracks/1
  # GET /tracks/1.xml
  def show
    @track = Track.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @track }
    end
  end

  # GET /tracks/new
  # GET /tracks/new.xml
  def new
    @track = Track.new
    @genres = Genre.find(:all, :order => "name")
    @moods = Mood.find(:all, :order => "name")
    @ragas = Raga.find(:all, :order => "name")
    @artists = Artist.find(:all, :order => "name")
  end

  # GET /tracks/1/edit
  def edit
    @track = Track.find(params[:id])
    @genres = Genre.find(:all, :order => "name")
    @moods = Mood.find(:all, :order => "name")
    @ragas = Raga.find(:all, :order => "name")
    @artists = Artist.find(:all, :order => "name")
  end

  # POST /tracks
  # POST /tracks.xml
  def create
    @track = Track.new(params[:track])
    respond_to do |format|
      if(@album.tracks << @track)
        flash[:notice] = 'Track was successfully created.'
        format.html { redirect_to(@album) }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new", :controller=>"tracks", :album_id => @album.id}
        format.xml  { render :xml => @track.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tracks/1
  # PUT /tracks/1.xml
  def update
    @track = Track.find(params[:id])
    respond_to do |format|
      if @track.update_attributes(params[:track])
        flash[:notice] = 'Track was successfully updated.'
        format.html { redirect_to(@album) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @track.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.xml
  def delete_track
    @track = Track.find(params[:id])
    @track.destroy

    respond_to do |format|
      format.html { redirect_to(url_for(:controller=>"albums", :id => @album.id,:action =>'tracks')) }
      format.xml  { head :ok }
    end
  end
  
  # DELETE /tracks/1
  # DELETE /tracks/1.xml
  def destroy
    @track = Track.find(params[:id])
    @track.destroy

    respond_to do |format|
      format.html { redirect_to(tracks_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_album
  @album_id = params[:album_id]
  redirect_to albums_url unless @album_id
  @album = Album.find(@album_id)
  end
  
end
