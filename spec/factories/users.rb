FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email-#{n}-#{Time.now.to_i}@example.com"  }
    password "password"
    name Faker::Name.name
    status ['PCV', 'RPCV', 'Interested'].sample
  end

 factory :test do
    email "sam@boss.com"
    password "password"
    name "Sam Samskies"
    status "RPCV" 
 end

 factory :RPCV, :parent => :user do
    status "RPCV"
  end

  factory :PCV, :parent => :user do
    status "PCV"
  end
end
