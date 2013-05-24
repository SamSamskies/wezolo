# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    status "MyString"
    sector ""
    username "MyString"
    name "MyString"
    avatar_url "MyString"
    password_digest "MyString"
  end
end
