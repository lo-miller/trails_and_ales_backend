json.array! @saved_hikes do |saved_hike| 
  json.partial! 'api/saved_hikes/saved_hike', saved_hike: saved_hike
end
