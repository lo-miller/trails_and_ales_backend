class RemoveFeaturesFromHikes < ActiveRecord::Migration[6.1]
  def change
    remove_column :hikes, :features, :text
  end
end
