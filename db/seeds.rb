require 'csv'
# Country.delete_all
# User.delete_all
# Profile.delete_all
# Involvement.delete_all
# BlogHost.delete_all
# Blog.delete_all
# Post.delete_all
# Message.delete_all

CSV.foreach("./db/countries.csv") do |row|
  Country.create(name: row.first)
end

AuthProvider.create(name: "google_oauth2")
AuthProvider.create(name: "tumblr")
blogger = BlogHost.create(name: 'blogger')
tumblr = BlogHost.create(name: 'tumblr')


# countries = Country.all
# test_user = FactoryGirl.create(:sam)
# FactoryGirl.create(:profile, user: test_user)

# 100.times do
#   FactoryGirl.create(:user, status: User.statuses_hash.map{|k,v| k}.sample, name: Faker::Name.name)
# end

# User.all.each do |u|
#   1.upto(rand(1..3)) do |i|
#     FactoryGirl.create(:involvement, user: u, country: countries.sample, sector: Involvement.sectors.sample)
#   end
#   FactoryGirl.create(:profile, user: u)
# end


# blogger = BlogHost.first
# user_ids = User.pluck(:id)
# 300.times do
#   blog = blogger.blogs.create(title: Faker::Company.catch_phrase, 
#                        url: 'http://' + Faker::Lorem.characters(10) + '.blogspot.com', 
#                        external_id: Array.new(7){rand 10}.join,
#                        user_id: user_ids.sample)
#   10.times do
#     blog.posts.create(title: Faker::Company.catch_phrase,
#                       body: Faker::Lorem.paragraph,
#                       published_at: (1..365).to_a.sample.days.ago)
#   end
# end
