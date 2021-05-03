class Api::TerritoriesController < ApplicationController
  def index
    p params[:location]
    p params
    # :params = {location: params[:location]}
    response = HTTP.get("https://native-land.ca/api/index.php?maps=territories", :params => {:position => params[:location]})
    render json: response.parse
  end

  def show
    render "show.json.jb"
  end
end
