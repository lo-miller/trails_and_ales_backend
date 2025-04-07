class Api::HikesController < ApplicationController
  def index
    @hikes = if params[:state].present?
      Hike.where(state: params[:state])
        .includes(:features)
        .limit(100)
    else
      Hike.includes(:features)
        .limit(100)
    end
    
    render :index
  end

  def show
    @hike = Hike.includes(:features).find_by(id: params[:id])
    render :show
  end

end
