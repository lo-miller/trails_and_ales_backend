class RemoveHikesFeaturesTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :hikes_features
  end
end
