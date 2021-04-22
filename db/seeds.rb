require 'open-uri'
require 'json'

Hike.delete_all
# hikes = JSON.parse(hikes.to_json)

hikes = ActiveSupport::JSON.decode(File.read("db/wta-parks-data.json"))

# hikes =  hikes[0]

hikes.each do |hike|
  Hike.create!(
    name: hike["name"],
    description: "",
    latitude: hike["coordinates"]["lat"],
    longitude: hike["coordinates"]["lon"],
    state: "WA",
    region: "",
    length: hike["length"],
    difficulty: "",
    type: "",
    highest_point: hike["elevation"]["Highest Point"],
    elevation_gain: hike["elevation"]["Gain"],
    features: hike["features"],
    url: hike["url"],
    required_pass: hike["requiredPass"]
  )
end