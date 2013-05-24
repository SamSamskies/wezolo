# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_post do
    title "MyString"
    body "MyText"
    published_at "2013-05-23 22:23:19"
    blog nil
  end
end
