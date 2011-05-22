
class GeoController < ApplicationController

    def set
      session[:geo] = { :lat => params[:lat], :lng => params[:lng] }
      render :nothing => true
    end

end
