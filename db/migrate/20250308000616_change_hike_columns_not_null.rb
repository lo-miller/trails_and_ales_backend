class ChangeHikeColumnsNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :hikes, :name, false
    change_column_null :hikes, :latitude, false
    change_column_null :hikes, :longitude, false
    change_column_null :hikes, :state, false
    change_column_null :hikes, :length, false
    change_column_null :hikes, :url, false
    change_column_null :hikes, :difficulty, false

  end
end
