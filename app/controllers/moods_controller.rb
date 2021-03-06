class MoodsController < ApplicationController
  # GET /moods
   # GET /moods.xml
   def index
     @moods = Mood.find(:all)

     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @moods }
     end
   end

   # GET /moods/1
   # GET /moods/1.xml
   def show
     @mood = Mood.find(params[:id])

     respond_to do |format|
       format.html # show.html.erb
       format.xml  { render :xml => @mood }
     end
   end

   # GET /moods/new
   # GET /moods/new.xml
   def new
     @mood = Mood.new

     respond_to do |format|
       format.html # new.html.erb
       format.xml  { render :xml => @mood }
     end
   end

   # GET /moods/1/edit
   def edit
     @mood = Mood.find(params[:id])
   end

   # POST /moods
   # POST /moods.xml
   def create
     @mood = Mood.new(params[:mood])

     respond_to do |format|
       if @mood.save
         flash[:notice] = 'Mood was successfully created.'
         format.html { redirect_to(@mood) }
         format.xml  { render :xml => @mood, :status => :created, :location => @mood }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @mood.errors, :status => :unprocessable_entity }
       end
     end
   end

   # PUT /moods/1
   # PUT /moods/1.xml
   def update
     @mood = Mood.find(params[:id])

     respond_to do |format|
       if @mood.update_attributes(params[:mood])
         flash[:notice] = 'Mood was successfully updated.'
         format.html { redirect_to(@mood) }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @mood.errors, :status => :unprocessable_entity }
       end
     end
   end



   # DELETE /moods/1
   # DELETE /moods/1.xml
   def destroy
     @mood = Mood.find(params[:id])
     @mood.destroy

     respond_to do |format|
       format.html { redirect_to(moods_url) }
       format.xml  { head :ok }
     end
   end
end
