# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message, :class => 'Messages' do
    message "MyString"
    user nil
    msg_type "MyString"
    status "MyString"
    parent nil
  end
end
