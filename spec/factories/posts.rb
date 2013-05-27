FactoryGirl.define do
  factory :post do
    title Faker::Company.catch_phrase
    body Faker::Lorem.paragraph
    published_at Time.now
    # (1..365).to_a.sample.days.ago
  end
end
