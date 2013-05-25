# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    status "MyString"
    sector "MyString"
    username "MyString"
    university "MyString"
    major "MyString"
    occupation "MyString"
    location "MyString"
    bio "MyText"
    photo_url "MyString"
    user nil
  end
end
