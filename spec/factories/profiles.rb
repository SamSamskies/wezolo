# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    status "PCV"
    sector Faker::Address.city
    name Faker::Name.first_name
    username Faker::Name.first_name + "#{Time.now.to_i}"
    university "MyString"
    major "Computer Science"
    occupation "Programmer"
    location "San Francisco"
    bio "MyText"
    photo_url "www.google.com"
    user nil
  end

 factory :RPCV, :parent => :profile do
    status "RPCV"
  end

  factory :IPCV, :parent => :profile do
    status "IPCV"
  end
end
