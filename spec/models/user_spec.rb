require 'spec_helper'

describe User do
  
  let!(:sammyboy) { create(:user, :name => 'sam') }

  let!(:google) { create(:auth_provider) }
  let!(:facebook) { create(:auth_provider, :name => 'Facebook') }
  let!(:tumblr) { create(:auth_provider, :name => 'Tumblr') }

  let!(:google_login_auth) { create(:authorization, :auth_provider => google) }
  let!(:fb_login_auth) { create(:authorization, :auth_provider => facebook) }
  let!(:tumblr_login_auth) { create(:authorization, :auth_provider => tumblr) }

  context "followed posts" do

  let!(:blogdude) { create(:user) }
  let!(:blogger) { create(:blog_host) }

  let!(:blog) { create(:blog) }
  let!(:post1) { create(:post, :published_at => (1..365).to_a.sample.days.ago) }
  let!(:post2) { create(:post, :published_at => (1..365).to_a.sample.days.ago) }
  let!(:post3) { create(:post,:published_at => (1..365).to_a.sample.days.ago) }
  let!(:spain) { create(:country, name: "spain") }

    it "user should not have any followed post without following other users" do
      sammyboy.followed_posts.empty?.should eq true
    end

    it "blogger can have post through a blog" do
      blogdude.blogs << blog
      blogdude.blogs.first.posts << post1
      blogdude.posts.count.should eq 1
    end

    it "a user following one user can see all their followed post" do
      blogdude.blogs << blog
      blogdude.blogs.first.posts << post1
      blogdude.blogs.first.posts << post2
      blogdude.followers << sammyboy
      sammyboy.followed_posts.count.should eq 2
    end

    it "countries_post returns post for that country" do
      blogdude.blogs << blog
      blogdude.blogs.first.posts << post1
      blogdude.blogs.first.posts << post2
      blogdude.countries << spain
      spain.followers << sammyboy
      sammyboy.countries_posts.count.should eq 2
    end
    it "hereos_posts returns post for that country" do
      blogdude.blogs << blog
      blogdude.blogs.first.posts << post1
      blogdude.blogs.first.posts << post2
      blogdude.followers << sammyboy
      sammyboy.heroes_posts.count.should eq 2
    end

    it "followed_post returns post from followed countries and heroes without duplicates" do
      blogdude.blogs << blog
      blogdude.blogs.first.posts << post1
      blogdude.blogs.first.posts << post2
      blogdude.followers << sammyboy
      blogdude.countries << spain
      spain.followers << sammyboy
      sammyboy.followed_posts.count.should eq 2
    end

    it "#followed_posts should return post ordered by published_at" do
      blogdude.blogs << blog
      blogdude.blogs.first.posts << post1
      blogdude.blogs.first.posts << post2
      blogdude.blogs.first.posts << post3
      blogdude.followers << sammyboy
      blogdude.countries << spain
      spain.followers << sammyboy
      dates = sammyboy.followed_posts.map(&:published_at)
      dates[2].should > dates[1]
    end
    it "#heroes_posts returns all the posts written by people that a user is following"

    it "#countries_posts returns all the posts written by people in a country that a user is following"

    it "#published_at should return array of posts ordered by published_at"

    
  end

  context "#user_followings_by_type" do
    let!(:justin_bieber) { create(:user, :name => "justin bieber") }
    let!(:oprah) { create(:user, :name => "oprah")}
    let!(:usa) { create(:country, :name => "USA")}
    let!(:togo) { create(:country, :name => "togo")}
    let!(:fan) { create(:user, :name => "fan")}

    before(:each) do
      fan.following_countries << [togo, usa]
      fan.heroes << [justin_bieber, oprah]
    end
    
    it "returns correct hash by calling #user_followings_by_type" do
      fan.user_followings_by_type.should eq({"User"=> [oprah.id, justin_bieber.id], "Country"=> [usa.id, togo.id]})
    end
  end

  context "authorization" do
    it "can have multiple authorizations" do
      sammyboy.authorizations << [google_login_auth, fb_login_auth, tumblr_login_auth]
      sammyboy.authorizations.count.should eq 3
      sammyboy.authorizations.should eq [tumblr_login_auth, fb_login_auth, google_login_auth]
    end

    it "can have multiple auth_providers" do
      sammyboy.authorizations << [google_login_auth, fb_login_auth, tumblr_login_auth]
      sammyboy.auth_providers.count.should eq 3
      sammyboy.auth_providers.should eq [tumblr, facebook, google]
    end
  end

end



