
class PlacesController < ApplicationController

    def index
    end

    def search
      query = "%#{params[:q]}%"
      render :json => Venue.where("name LIKE ?", query)
    end

end
