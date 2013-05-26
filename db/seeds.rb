require 'CSV'
Country.delete_all
User.delete_all
Profile.delete_all
Involvement.delete_all


CSV.foreach("./db/countries.csv") do |row|
  Country.create(name: row.first)
end

test_user = FactoryGirl.create :test
FactoryGirl.create(:profile, user: test_user)
FactoryGirl.create_list (:profile, 100)

User.all.each do |u|
  FactoryGirl.create_list(:involvement, [1,2,3].sample, user: u)
end

blogger = BlogHost.create(name: 'Blogger')
blogger = BlogHost.first
user_ids = User.pluck(:id)
300.times do
  blog = blogger.blogs.create(title: Faker::Company.catch_phrase, 
                       url: 'http://' + Faker::Lorem.characters(10) + '.blogspot.com', 
                       external_id: Array.new(7){rand 10}.join,
                       user_id: user_ids.sample)
  10.times do
    blog.posts.create(title: Faker::Company.catch_phrase,
                      body: Faker::Lorem.paragraph,
                      published_at: (1..365).to_a.sample.days.ago)
  end
end

AuthProvider.create(name: "google_oauth2")
