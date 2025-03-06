class AddRatingToHikes < ActiveRecord::Migration[6.1]
  def change
    add_column :hikes, :rating, :float
  end
end
