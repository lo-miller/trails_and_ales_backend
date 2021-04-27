class Api::SearchResultsController < ApplicationController
  def index
    p params[:location]
    # :params = {"location": params[:location]}
    response = HTTP.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=brewery&keyword=brewery&radius=5000&key=#{Rails.application.credentials.google_maps_api[:api_key]}", :params => {:location => params[:location]})
    render json: response.parse
  end

  def show
    render "show.json.jb"
  end
end
