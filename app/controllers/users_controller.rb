
class UsersController < ApplicationController

    def get
      
      id = params[:id]
      @user = User.where("id = ?", id).first
      
      @rankings = @user.rankings.by_dish.by_rank      
      @dishes = @rankings.map{ |r| r.dish.name }.sort.uniq
      
    end

end
