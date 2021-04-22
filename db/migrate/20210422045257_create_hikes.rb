class CreateHikes < ActiveRecord::Migration[6.1]
  def change
    create_table :hikes do |t|
      t.string :name
      t.text :description
      t.float :latitude
      t.float :longitude
      t.string :state
      t.string :region
      t.float :length
      t.string :difficulty
      t.string :type
      t.float :highest_point
      t.float :elevation_gain
      t.text :features
      t.string :url
      t.string :required_pass

      t.timestamps
    end
  end
end
