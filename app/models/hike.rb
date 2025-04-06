class Hike < ApplicationRecord
  has_many :saved_hikes
  has_and_belongs_to_many :features

  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :state, presence: true
  validates :length, presence: true
  validates :difficulty, presence: true
  validates :url, presence: true
end
