class Api::SearchResultsController < ApplicationController
  def state_geographic_center
    begin
      response = HTTP.get(
        "https://maps.googleapis.com/maps/api/geocode/json?&key=#{Rails.application.credentials.google_maps_api[:api_key]}",
        params: { address: params[:address] }
      )
      render json: response.parse
    rescue HTTP::Error => e
      render json: { error: 'Geocoding API service unavailable' }, status: :service_unavailable
    end
  end
  
  def brewery_search_index
    begin
      response = HTTP.get(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=brewery&keyword=brewery&key=#{Rails.application.credentials.google_maps_api[:api_key]}",
        params: { location: params[:location], radius: params[:radius] }
      )
      render json: response.parse
    rescue HTTP::Error => e
      render json: { error: 'Places API service unavailable' }, status: :service_unavailable
    end
  end
end
