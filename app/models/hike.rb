class Hike < ApplicationRecord
  has_many :saved_hikes
  has_and_belongs_to_many :features
end
