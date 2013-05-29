FactoryGirl.define do
  factory :involvement do
    description Faker::Lorem.paragraph
    sector ['ICT', 'Health', 'Agriculture', 'Community Development', 'Education'].sample
    start_date (10..20).to_a.sample.years.ago
    end_date (3..10).to_a.sample.years.ago
  end
end
