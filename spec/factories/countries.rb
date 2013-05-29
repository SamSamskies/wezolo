FactoryGirl.define do
  factory :country do
    name Faker::Address.city
  end

  factory :USA do
    name "USA"
  end

end
