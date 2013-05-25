# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authorization do
    uid '1234567'
    user nil
    auth_provider nil
  end

end
