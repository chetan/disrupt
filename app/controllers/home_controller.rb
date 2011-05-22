
class HomeController < ApplicationController

    def index

      load_user_data()

      @recent_rankings = Ranking.order("updated_at DESC")
    end

end
