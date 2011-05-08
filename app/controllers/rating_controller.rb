class RatingController < ApplicationController
  before_filter :require_user
  
  def rate
      @artist = Artist.find(params[:id])
      Rating.delete_all(["rateable_type = 'Artist' AND rateable_id = ? AND user_id = ?", 
        @artist.id, current_user.id])
      @artist.add_rating Rating.new(:rating => params[:rating], 
        :user_id => current_user.id)
    end

end
