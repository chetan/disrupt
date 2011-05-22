
class HomeController < ApplicationController

    def index
      @recent_rankings = Ranking.order("updated_at DESC")
    end

end
