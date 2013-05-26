# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    location
    bio
    photo_url
    user
  end

 factory :RPCV, :parent => :profile do
    status "RPCV"
  end

  factory :IPCV, :parent => :profile do
    status "IPCV"
  end
end
