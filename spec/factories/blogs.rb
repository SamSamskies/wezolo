FactoryGirl.define do
  factory :blog do
    title Faker::Company.catch_phrase
    sequence(:url) {|n| "http://#{n}#{Faker::Lorem.characters(10)}.blogspot.com" }
    external_id '1234567'
  end
end
