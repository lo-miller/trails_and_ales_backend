class Api::BreweriesController < ApplicationController
  def index
    begin
      response = HTTP.get(
        "/v4/brewery/info/BREWERY_ID",
        params: {
          location: params[:location],
          radius: params[:radius]
        }
      )
      render json: response.parse
    rescue HTTP::Error => e
      render json: { error: 'Brewery API service unavailable' }, status: :service_unavailable
    end
  end

  def show
    render "show.json.jbuilder"
  end
end
