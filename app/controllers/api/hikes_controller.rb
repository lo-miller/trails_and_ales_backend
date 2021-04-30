class Api::HikesController < ApplicationController
  def index
    @hikes = Hike.limit(100)
    render "index.json.jb"
  end

  def show
    p params[:id]
    @hike = Hike.find_by(id: params[:id])
    render "show.json.jb"
  end

end
