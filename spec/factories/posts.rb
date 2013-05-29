FactoryGirl.define do
  factory :post do
    title Faker::Company.catch_phrase
    body Faker::Lorem.paragraph
    published_at Time.now
  end
end
