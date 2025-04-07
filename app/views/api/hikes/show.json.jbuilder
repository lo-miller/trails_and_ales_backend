if @hike
  json.partial! 'api/hikes/hike', hike: @hike
else
  json.error "Hike not found"
end