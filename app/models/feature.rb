class Feature < ApplicationRecord
  has_and_belongs_to_many :hikes
  
  validates :feature_name, presence: true, uniqueness: true
end
