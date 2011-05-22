begin
  FOURSQUARE_CONFIG = YAML.load(File.open(File.join(RAILS_ROOT, "config", "foursquare.yml")))
rescue => ex
  puts "Couldn't load config/foursquare.yml"
  puts "Exiting"
  exit
end
