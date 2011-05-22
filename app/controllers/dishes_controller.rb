
class DishesController < ApplicationController

    def index
    end

    def search
      query = "%#{params[:q]}%"
      render :json => Dish.where("name LIKE ?", query)
    end

end
