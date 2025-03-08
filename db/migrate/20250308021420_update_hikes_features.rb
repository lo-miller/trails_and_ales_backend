class UpdateHikesFeatures < ActiveRecord::Migration[6.1]
  def change
    path = "../trail_data/state_trail_data"

    Dir.foreach(path) do |filename| 
      p filename
      next if filename == '.' || filename == '..' || filename == '.DS_Store'

      state_file = File.read("#{path}/#{filename}")
      hikes = JSON.parse(state_file)

      hikes.each do |hike|
        Hike.update!(
          features: hike["feature_names"],
        )
      end

      end
    end
  end
end
