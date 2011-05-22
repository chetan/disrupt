
require 'global'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_user_data

  def fb_token
    f = cookies.keys.find{ |k| k =~ /^fbs_/ }
    cookies[f] =~ /^"access_token=(.*?)&/
    token = $1
  end

  def load_user_data
    fbgraph = Koala::Facebook::GraphAPI.new(fb_token())
    @fbuser = fbgraph.get_object("me")
    @fbphoto = fbgraph.get_picture("me")
    @current_user = User.where("facebook_id = ?", @fbuser["id"]).first if @fbuser

    GlobalData.fbgraph = fbgraph

    # # see if user has any friends in the system and create links
    # friends = @fbgraph.get_connections("me", "friends")
    # users_friends = []
    # friends.each do |fr|
    #
    #   us = User.where("facebook_id = ?", fr["id"])
    #   if not us.empty? then
    #     u = User.new
    #     u.name = fr["name"]
    #     u.facebook_id = fr["id"]
    #     u.save!
    #     users_friends << u.id
    #   end
    #
    # end
    #
    # users_friends.each do |u|
    #   f = Friend.new
    #   f.user_id = @user.id
    #   f.friend_id = u
    #   f.save!
    # end

  end

end
