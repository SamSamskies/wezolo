FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email-#{n}-#{Time.now.to_i}@example.com"  }
    password_digest "password"
  end
end
