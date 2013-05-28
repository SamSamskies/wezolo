# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :incoming do
    user nil
    message "MyString"
    status "MyString"
  end
end
