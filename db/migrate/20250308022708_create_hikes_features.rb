class CreateHikesFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :features do |t|
      t.string :feature_name
      t.timestamps
    end
    
    create_table :hikes_features, id: false do |t|
      t.belongs_to :hikes
      t.belongs_to :features
    end
  end
end
