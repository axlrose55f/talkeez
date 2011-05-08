class TriviasController < ApplicationController
  # GET /trivias
  # GET /trivias.xml
  def index
    @trivias = Trivia.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trivias }
    end
  end

  # GET /trivias/1
  # GET /trivias/1.xml
  def show
    @trivia = Trivia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trivia }
    end
  end

  # GET /trivias/new
  # GET /trivias/new.xml
  def new
    @trivia = Trivia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trivia }
    end
  end

  # GET /trivias/1/edit
  def edit
    @trivia = Trivia.find(params[:id])
  end

  # POST /trivias
  # POST /trivias.xml
  def create
    @trivia = Trivia.new(params[:trivia])

    respond_to do |format|
      if @trivia.save
        flash[:notice] = 'Trivia was successfully created.'
        format.html { redirect_to(@trivia) }
        format.xml  { render :xml => @trivia, :status => :created, :location => @trivia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trivia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trivias/1
  # PUT /trivias/1.xml
  def update
    @trivia = Trivia.find(params[:id])

    respond_to do |format|
      if @trivia.update_attributes(params[:trivia])
        flash[:notice] = 'Trivia was successfully updated.'
        format.html { redirect_to(@trivia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trivia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trivias/1
  # DELETE /trivias/1.xml
  def destroy
    @trivia = Trivia.find(params[:id])
    @trivia.destroy

    respond_to do |format|
      format.html { redirect_to(trivias_url) }
      format.xml  { head :ok }
    end
  end
end
