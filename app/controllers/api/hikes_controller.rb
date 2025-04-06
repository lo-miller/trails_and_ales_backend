class Api::HikesController < ApplicationController
  def index
    @hikes = Hike.where(id: 5211) + Hike.where(state: params[:state] || "WA").limit(100) 
    render "index.json.jb"
  end

  def show
    @hike = Hike.find_by(id: params[:id])
    render "show.json.jb"
  end

end
