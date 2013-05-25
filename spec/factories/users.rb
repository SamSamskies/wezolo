# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email-#{n}-#{Time.now.to_i}@example.com"  }
    password_digest "password"
  end
end
