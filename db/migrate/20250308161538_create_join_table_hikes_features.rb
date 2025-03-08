class CreateJoinTableHikesFeatures < ActiveRecord::Migration[6.1]
  def change
    create_join_table :hikes, :features do |t|
      # t.index [:hike_id, :feature_id]
      # t.index [:feature_id, :hike_id]
    end
  end
end
