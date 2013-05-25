require 'CSV'
CSV.foreach("./db/countries.csv") do |row|
  Country.create(name: row.first)
end

User.create(status: 'PCV', 
            email: 'test@pc.com',
            sector: 'Business',
            username: 'test',
            name: 'test',
            password: 'password')

100.times do 
  User.create(status: ['PCV', 'RPCV', 'Interested'].sample, 
              email: Faker::Internet.email, 
              sector: ['Business', 'Health', 'Agriculture'].sample, 
              username: Faker::Internet.user_name,
              name: Faker::Name.name,
              avatar_url: Faker::Internet.url,
              password: 'password')
end

countries = Country.all
User.all.each do |user|
  user.countries << countries.sample
end


blogger = BlogHost.create(name: 'Blogger')
blogger = BlogHost.first
user_ids = User.pluck(:id)
100.times do
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
