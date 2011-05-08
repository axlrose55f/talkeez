class RagasController < ApplicationController
  # GET /ragas
   # GET /ragas.xml
   def index
     @ragas = Raga.find(:all)

     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @ragas }
     end
   end

   # GET /ragas/1
   # GET /ragas/1.xml
   def show
     @raga = Raga.find(params[:id])

     respond_to do |format|
       format.html # show.html.erb
       format.xml  { render :xml => @raga }
     end
   end

   # GET /ragas/new
   # GET /ragas/new.xml
   def new
     @raga = Raga.new

     respond_to do |format|
       format.html # new.html.erb
       format.xml  { render :xml => @raga }
     end
   end

   # GET /ragas/1/edit
   def edit
     @raga = Raga.find(params[:id])
   end

   # POST /ragas
   # POST /ragas.xml
   def create
     @raga = Raga.new(params[:raga])

     respond_to do |format|
       if @raga.save
         flash[:notice] = 'Raga was successfully created.'
         format.html { redirect_to(@raga) }
         format.xml  { render :xml => @raga, :status => :created, :location => @raga }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @raga.errors, :status => :unprocessable_entity }
       end
     end
   end

   # PUT /ragas/1
   # PUT /ragas/1.xml
   def update
     @raga = Raga.find(params[:id])

     respond_to do |format|
       if @raga.update_attributes(params[:raga])
         flash[:notice] = 'Raga was successfully updated.'
         format.html { redirect_to(@raga) }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @raga.errors, :status => :unprocessable_entity }
       end
     end
   end



   # DELETE /ragas/1
   # DELETE /ragas/1.xml
   def destroy
     @raga = Raga.find(params[:id])
     @raga.destroy

     respond_to do |format|
       format.html { redirect_to(ragas_url) }
       format.xml  { head :ok }
     end
   end
end
