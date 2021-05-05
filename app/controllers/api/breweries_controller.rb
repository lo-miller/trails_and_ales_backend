class Api::BreweriesController < ApplicationController
  def index
    p params[:location]
    p params
    # :params = {location: params[:location]}
    response = HTTP.get("/v4/brewery/info/BREWERY_ID", :params => {:location => params[:location], :radius => params[:radius]})
    render json: response.parse
  end

  def show
    render "show.json.jb"
  end
end
