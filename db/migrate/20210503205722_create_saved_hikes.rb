class CreateSavedHikes < ActiveRecord::Migration[6.1]
  def change
    create_table :saved_hikes do |t|
      t.integer :user_id
      t.integer :hike_id
      t.string :status

      t.timestamps
    end
  end
end
