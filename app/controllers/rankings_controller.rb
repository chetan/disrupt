
class RankingsController < ApplicationController
  
  def add
  end
  
  def search
    # TODO add user_id to lookup
    render :json => 
      Ranking.
        joins("LEFT JOIN venues ON venues.id = rankings.venue_id").
        where("dish_id = ?", params[:dish_id]).
        order("position ASC").
        to_json(:include => [:venue, :user, :dish])
  end
  
  def save
    
    rank = Ranking.new
    rank.user_id = @current_user.id
    rank.venue_id = params[:place_id]
    rank.dish_id = params[:dish_id]
    rank.position = params[:position]
    rank.save!
    
    redirect_to "/"
    
  end
  
end
