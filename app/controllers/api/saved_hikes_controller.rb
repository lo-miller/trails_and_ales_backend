class Api::SavedHikesController < ApplicationController
  before_action :authenticate_user

  def index
    @saved_hikes = current_user.saved_hikes.where(status: "saved")
    render "index.json.jb"
  end
  
  def create
    @saved_hike = SavedHike.create(
      user_id: current_user.id,
      hike_id: params[:hike_id],
      status: "saved",
      brewery_name: params[:brewery_name]
    )
    render "show.json.jb"
  end

end
