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

    it "returns correct hash by calling #user_followings_by_type"
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
