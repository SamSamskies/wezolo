require 'spec_helper'

describe Authorization do

  let!(:facebook) { create(:auth_provider, :name => 'Facebook') }

  let!(:fanguy) { create(:user, :name => 'fanguy') }

  let!(:fb_login_auth) { create(:authorization, :user => fanguy) }

  it "has a user" do
    fb_login_auth.user = fanguy
    fb_login_auth.save
    fb_login_auth.reload
    fb_login_auth.user.should eq fanguy
  end

  it "has one auth provider" do
    fb_login_auth.auth_provider = facebook
    fb_login_auth.save
    fb_login_auth.reload
    fb_login_auth.auth_provider.should eq facebook
  end

end
