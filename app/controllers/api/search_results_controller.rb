class Api::SearchResultsController < ApplicationController
  def state_geographic_center
    # response = HTTP.get("    https://maps.googleapis.com/maps/api/geocode/outputFormat?parameters"
    response = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?&key=#{Rails.application.credentials.google_maps_api[:api_key]}", :params => {:address => params[:address]})
    render json: response.parse
    p response
  end
  
  def brewery_search_index
    # p params[:location]
    # p params
    # :params = {location: params[:location]}
    response = HTTP.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=brewery&keyword=brewery&key=#{Rails.application.credentials.google_maps_api[:api_key]}", :params => {:location => params[:location], :radius => params[:radius]})
    render json: response.parse
  end

  def show
    render "show.json.jb"
  end
end
