FactoryBot.define do
  factory :hike do
    name { Faker::Address.street_name + " Trail" }
    description { Faker::Lorem.paragraph }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    state { Faker::Address.state_abbr }
    region { Faker::Address.city }
    length { Faker::Number.decimal(l_digits: 2, r_digits: 1) }
    difficulty { ['easy', 'moderate', 'hard'].sample }
    route_type { ['loop', 'out and back', 'point to point'].sample }
    highest_point { Faker::Number.decimal(l_digits: 4, r_digits: 1) }
    elevation_gain { Faker::Number.decimal(l_digits: 3, r_digits: 1) }
    url { Faker::Internet.url }
    required_pass { ['Northwest Forest Pass', 'America the Beautiful', 'None'].sample }
    image { Faker::Internet.url }
    rating { Faker::Number.between(from: 1.0, to: 5.0).round(1) }
    photo_url { Faker::Internet.url }
  end
end 