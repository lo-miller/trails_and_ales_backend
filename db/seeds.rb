require 'open-uri'
require 'json'

# Hike.delete_all

hikes = ActiveSupport::JSON.decode(File.read("db/wta-parks-data.json"))

# hikes =  hikes[0]

hikes.each do |hike|
  Hike.create!(
    name: hike["name"],
    description: hike["description"] || "",
    latitude: hike["coordinates"]["lat"],
    longitude: hike["coordinates"]["lon"],
    state: hike["state" || "WA",
    region: "",
    length: hike["length"],
    difficulty: hike["difficulty"] || "",
    type: hike["type"] || "",
    highest_point: hike["elevation"]["Highest Point"],
    elevation_gain: hike["elevation"]["Gain"],
    features: hike["features"],
    url: hike["url"],
    required_pass: hike["requiredPass"]
  )
end