# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog do
    title Faker::Company.catch_phrase
    url "http://#{Faker::Lorem.characters(10)}.blogspot.com"
    external_id '1234567'
  end
end
