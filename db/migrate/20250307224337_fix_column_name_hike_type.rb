class FixColumnNameHikeType < ActiveRecord::Migration[6.1]
  def change
    rename_column :hikes, :type, :route_type
  end
end
