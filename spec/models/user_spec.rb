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
    it "#followed_posts should not return any duplicate posts"

    it "#followed_posts should?/shouldnot? return any posts written by the current user if the user is in the country that he/she is in"

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
