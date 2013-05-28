FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email-#{n}-#{Time.now.to_i}@example.com"  }
    password "password"
    name Faker::Name.name
    phone_number "+11234567890"
    status ['PCV', 'RPCV', 'Interested'].sample
  end

 factory :sam, :parent => :user do
    email "sam@gmail.com"
    password "password"
    name "Sam Samskies"
    status "RPCV" 
 end

  factory :fab, :parent => :user do
    email "fab@gmail.com"
    password "password"
    name "Fab Mackojc"
    status "Interested" 
 end

 factory :rpcv, :parent => :user do
    status "RPCV"
  end

  factory :pcv, :parent => :user do
    status "PCV"
  end

  factory :profile do
    location Faker::Address.city
    bio Faker::Lorem.paragraph
    photo_url "http://agarwal.seas.upenn.edu/wp-content/uploads/2011/01/person_default_208x208-1.png"
    user
  end

end
