FactoryBot.define do
  factory :saved_hike do
    association :user
    association :hike
    status { ['want_to_go', 'completed', 'favorite'].sample }
    brewery_name { Faker::Company.name }
  end
end 