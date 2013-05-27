# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outgoing do
    user nil
    message "MyString"
    question nil
  end
end
