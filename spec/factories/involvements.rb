FactoryGirl.define do
  factory :involvement do
    description Faker::Lorem.paragraph
    sector ['ict', 'business', 'education', 'health', 'community development', 'environment', 'youth development', 'agriculture', 'other'].sample
    start_date (10..20).to_a.sample.years.ago
    end_date (3..10).to_a.sample.years.ago
    country
  end
end
