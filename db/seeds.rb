require 'open-uri'
require 'json'
require 'pathname'


# Hike.delete_all

# hikes = ActiveSupport::JSON.decode(File.read("db/wta-parks-data.json"))

# hikes =  hikes[0]

# hikes.each do |hike|
#   Hike.create!(
#     name: hike["name"],
#     description: hike["description"] || "",
#     latitude: hike["coordinates"]["lat"],
#     longitude: hike["coordinates"]["lon"],
#     state: hike["state"] || "WA",
#     region: "",
#     length: hike["length"],
#     difficulty: hike["difficulty"] || "",
#     type: hike["type"] || "",
#     highest_point: hike["elevation"]["Highest Point"],
#     elevation_gain: hike["elevation"]["Gain"],
#     features: hike["features"],
#     url: hike["url"],
#     required_pass: hike["requiredPass"],
#     rating: hike["avg_rating"]
#   )
# end

path = "../trail_data/state_trail_data"

Dir.foreach(path) do |file| 
  state = File.basename(file, ".json")
  

  # hikes = JSON.parse
  # hikes = JSON.parse(File.read(file))
  # hikes = ActiveSupport::JSON.decode(File.read(file))
  # p hikes
  # hikes.each do |hike|
    # Hike.create!(
    #   name: hike["name"],
    #   description: hike["overview"] || "",
    #   latitude: hike["_geoloc"]["lat"],
    #   longitude: hike["_geoloc"]["lon"],
    #   state: hike["state_name"] || state,
    #   region: hike["area_name"] || "",
    #   length: hike["length"],
    #   difficulty: hike["difficulty_rating"] || "",
    #   type: hike["route_type"] || "",
    #   highest_point: "",
    #   elevation_gain: hike["elevation_gain"],
    #   features: hike["features"],
    #   url: hike["url"],
    #   required_pass: hike["requiredPass"],
    #   rating: hike["avg_rating"],
    #   photo_url: hike["profile_photo_url"]
    # )
  # end

  puts "State is #{state}" 
  # p hike
end

#route type: "L" = loop, "O" = out-and-back, "P" = point-to-point