# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    status "PCV"
    sector Faker::Address.city
    username Faker::Name.first_name
    sequence(:email) {|n| "email-#{n}-#{Time.now.to_i}@example.com"  }
    name Faker::Name.first_name
    avatar_url "www.google.com"
    password_digest "password"
  end


  factory :RPCV, :parent => :user do
    status "RPCV"
  end

  factory :IPCV, :parent => :user do
    status "IPCV"
  end

end
