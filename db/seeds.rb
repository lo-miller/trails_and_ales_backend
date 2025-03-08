require 'open-uri'
require 'json'

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
#     route_type: hike["type"] || "",
#     highest_point: hike["elevation"]["Highest Point"],
#     elevation_gain: hike["elevation"]["Gain"],
#     features: hike["features"],
#     url: hike["url"],
#     required_pass: hike["requiredPass"],
#     rating: hike["avg_rating"]
#   )
# end

path = "../trail_data/state_trail_data"

Dir.foreach(path) do |filename| 
  p filename
  next if filename == '.' || filename == '..' || filename == '.DS_Store'

  state_file = File.read("#{path}/#{filename}")
  hikes = JSON.parse(state_file)

  route_type_map = { "L" => "Loop", "O" => "Out-and-back", "P" => "Point-to-point" }
  difficulty_map = { "1" => "Easy", "3" => "Moderate", "5" => "Hard", "7" => "Hard" }

  hikes.each do |hike|
    if Hike.exists?(name: hike["name"])
      @this_hike = Hike.find_by(name: hike["name"])
    else
      @this_hike = Hike.create!(
        name: hike["name"],
        description: hike["overview"] || "",
        latitude: hike["_geoloc"]["lat"],
        longitude: hike["_geoloc"]["lng"],
        state: hike["state_name"] || state,
        region: hike["area_name"] || "",
        length: hike["length"],
        difficulty: difficulty_map[hike["difficulty_rating"]],
        route_type: route_type_map[hike["route_type"]],
        highest_point: "",
        elevation_gain: hike["elevation_gain"],
        url: "https://www.alltrails.com/trail/#{hike["slug"]}",
        required_pass: hike["requiredPass"],
        rating: hike["avg_rating"],
        photo_url: hike["profile_photo_url"]
      )
    end

    features = hike["feature_names"] 
   
    features.each { |i|
      if Feature.exists?(feature_name: i)
        @this_hike.features << Feature.where(feature_name: i)
      else
        f = Feature.create!(feature_name: i)
        @this_hike.features << f
      end
    }
  end



end