
def get_foursquare_client
  Foursquare2::Client.new(:client_id => FOURSQUARE_CONFIG["client_id"],
                          :client_secret => FOURSQUARE_CONFIG["client_secret"])
end