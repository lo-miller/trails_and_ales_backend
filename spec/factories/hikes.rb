FactoryBot.define do
  factory :hike do
    sequence(:name) { |n| "Test Hike #{n}" }
    description { "A beautiful hiking trail" }
    latitude { rand(30.0..49.0) }
    longitude { rand(-125.0..-67.0) }
    state { ['WA', 'OR', 'CA', 'ID'].sample }
    region { "Pacific Northwest" }
    length { rand(1.0..15.0).round(1) }
    difficulty { ['easy', 'moderate', 'hard'].sample }
    route_type { ['loop', 'out and back', 'point to point'].sample }
    elevation_gain { rand(100..5000) }
    url { "https://example.com/hike-#{SecureRandom.hex(8)}" }
    rating { rand(1.0..5.0).round(1) }
  end
end 