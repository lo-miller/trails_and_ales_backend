json.array! @hikes do |hike|
  json.partial! 'api/hikes/hike', hike: hike
end