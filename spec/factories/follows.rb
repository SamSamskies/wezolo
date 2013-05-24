# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :follow do
    followable_id 1
    followable_type "MyString"
    follower nil
  end
end
