
require 'foursquare'

class PlacesController < ApplicationController

    def index
    end

    def search
      query = "%#{params[:q]}%"

      @venues = Venue.where("name LIKE ?", query)

      # get matching venues from 4sq
      client = get_foursquare_client()
      ll = session[:geo][:lat] + "," + session[:geo][:lng]
      ret = client.search_venues(:ll => ll, :query => query)

      fvenues = ret.groups.first.items
      fvenues.each do |v|

        id = v.id
        name = v.name

        ev = Venue.where("foursquare_id = ?", id)
        if ev.empty? then
          nv = Venue.new
          nv.name = name
          nv.foursquare_id = id
          nv.save!
          @venues << nv

        else
          @venues << ev.first if not @venues.include? ev.first
        end

      end

      render :json => @venues
    end

end
