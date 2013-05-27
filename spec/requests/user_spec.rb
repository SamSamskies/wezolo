require 'spec_helper'

describe "When I visit the homepage" do

  let!(:user) { create(:test) }

  it "can be seen" do
    # visit root_path # doesn't work?
    visit '/'
  end

  context "login" do

    it "has a login button" do
      visit '/'
      page.should have_content("Log in")
    end

    it "brings up login modal" do
      visit '/'
      click_link("Log in")
      find("#loginModal")['aria-hidden'].should eq "false"
    end

    it "user can login" do
      visit '/'
      click_link("Log in")
      fill_in 'email', :with => 'sam@boss.com'
      fill_in 'password', :with => 'password'
      find(".loginmein").click
      sleep 2
      current_path.should eq "/home"
    end

  end

  context "signup" do

    it "has a signup button" do
      visit '/'
      page.should have_content("Sign up")
    end

    it "brings up signup modal" do
      visit '/'
      click_link("Sign up")
      find("#signupModal")['aria-hidden'].should eq "false"
    end

    it "shows errors when passwords don't match" do
      visit '/'
      click_link("Sign up")
      find('.signup-error').text.should eq ""
      sleep(1)
      fill_in 'name', :with => 'Jimmy'
      fill_in 'email', :with => 'jimmy@email.com'
      fill_in 'password', :with => 'password'
      fill_in 'password_confirmation', :with => 'password1'
      find(".createaccount").click
      find('.signup-error').text.should eq "Password doesn't match confirmation"
    end

    it "shows errors when user email already exist" do
      visit '/'
      click_link("Sign up")
      find('.signup-error').text.should eq ""
      sleep(1)
      fill_in 'name', :with => 'Sam Samskies'
      fill_in 'email', :with => 'sam@boss.com'
      fill_in 'password', :with => 'password'
      fill_in 'password_confirmation', :with => 'password'
      find(".createaccount").click
      find('.signup-error').text.should eq "Email has already been taken"
    end

  end
  context "User Not Logged in" do
    it "should not beable to see newsfeed if not logged in" do
      pending
    #   visit '/home'
    #   uri = URI.parse(current_url)
    #   "#{uri.path}".should == "/"
    end
  end
end
