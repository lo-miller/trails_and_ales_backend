class AddBreweryToSavedHikes < ActiveRecord::Migration[6.1]
  def change
    add_column :saved_hikes, :brewery_name, :string 
  end
end
