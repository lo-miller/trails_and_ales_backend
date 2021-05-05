class AddImageToHikesAddBreweryToSavedHikes < ActiveRecord::Migration[6.1]
  def change
    add_column :hikes, :image, :string
  end
end
