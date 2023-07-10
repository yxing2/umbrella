#Ask the user for their location.
pp "Hi, where are you located?"

#Get and store the user’s location.
user_location = gets.chomp.gsub(" ", "%20") 
#user_location = "Chicago"

#Get the user’s latitude and longitude from the Google Maps API.
maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAP_KEY")
pp maps_url
require "http"
raw_response = HTTP.get(maps_url).to_s

require "json"
parsed_response = JSON.parse(raw_response)
#pp parsed_response
results = parsed_response.fetch("results")
#pp results.class

first_result = results.at(0)
#pp first_result
geo = first_result.fetch("geometry")
loc = geo.fetch("location")
latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

#Get the weather at the user’s coordinates from the Pirate Weather API.
weather_url = "https://api.pirateweather.net/forecast/" + ENV.fetch("PIRATE_WEATHER_KEY") + "/" + latitude.to_s + "," + longitude.to_s 
#pp weather_url
raw_weather = HTTP.get(weather_url).to_s
parsed_response = JSON.parse(raw_weather)

#Display the current temperature and summary of the weather for the next hour.
currently_hash = parsed_response.fetch("currently")
current_temp = currently_hash.fetch("temperature")
puts "The current temperature is " + current_temp.to_s + "."
