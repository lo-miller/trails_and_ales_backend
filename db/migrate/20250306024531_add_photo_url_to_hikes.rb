class AddPhotoUrlToHikes < ActiveRecord::Migration[6.1]
  def change
    add_column :hikes, :photo_url, :string
  end
end
