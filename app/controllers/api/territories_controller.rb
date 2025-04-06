class Api::TerritoriesController < ApplicationController
  def index
    begin
      response = HTTP.get(
        "https://native-land.ca/api/index.php?maps=territories",
        params: { position: params[:location] }
      )
      render json: response.parse
    rescue HTTP::Error => e
      render json: { error: 'Native Land API service unavailable' }, status: :service_unavailable
    end
  end
end
