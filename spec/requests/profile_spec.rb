require 'spec_helper'

describe "Profile" do

  let!(:profile) { create(:profile) }

  it "can be seen" do
    # visit root_path # doesn't work?
    page.set_rack_session(:user_id => profile.user.id)
    visit '/'
    find('.dropdown-toggle').click
    click_link("Profile")
    save_page
    current_path.should eq "/users/#{profile.user.id}"
  end

  it "displays the user's name" do
    page.set_rack_session(:user_id => profile.user.id)
    visit '/'
    find('.dropdown-toggle').click
    click_link("Profile")
    page.should have_content("#{profile.user.name}")
  end

  # it "displays the user's status"

  # context "login" do
  #   it "has a login button" do
  #     visit '/'
  #     page.should have_content("Log in")
  #   end

  #   it "brings up login modal" do
  #     visit '/'
  #     click_link("Log in")
  #     find("#loginModal")['aria-hidden'].should eq "false"
  #   end

  #   it "will redirect to add new involvement" do
  #     create(:sam)
  #     visit '/'
  #     click_link("Log in")
  #     fill_in 'email', :with => 'sam@gmail.com'
  #     fill_in 'password', :with => 'password'
  #     find(".loginmein").click
  #     sleep 1
  #     current_path.should eq "/involvements/new"
  #   end

  #   it "will display the user's email address" do
  #     create(:sam)
  #     visit '/'
  #     click_link("Log in")
  #     fill_in 'email', :with => 'sam@gmail.com'
  #     fill_in 'password', :with => 'password'
  #     find(".loginmein").click
  #     sleep 1
  #     find('.dropdown-toggle').text.should eq "sam@gmail.com"
  #   end
  # end

  # context "logout" do
  #   it "has a logout button if logged in" do
  #     stub_current_user(user)
  #     visit '/'
  #     find('.dropdown-toggle').click
  #     page.should have_content("Log out")
  #   end

  #   it "will redirect to the home page and display the login button" do
  #     page.set_rack_session(:user_id => user.id)
  #     visit '/home'
  #     find('.dropdown-toggle').click
  #     click_link("Log out")
  #     sleep(1)
  #     current_path.should eq '/'
  #     page.should have_content("Log in")
  #   end
  # end

  # context "signup" do

  #   it "has a signup button" do
  #     visit '/'
  #     page.should have_content("Sign up")
  #   end

  #   it "brings up signup modal" do
  #     visit '/'
  #     click_link("Sign up")
  #     find("#signupModal")['aria-hidden'].should eq "false"
  #   end

  #   it "shows errors when passwords don't match" do
  #     visit '/'
  #     click_link("Sign up")
  #     find('.signup-error').text.should eq ""
  #     sleep(1)
  #     fill_in 'name', :with => 'Jimmy'
  #     fill_in 'email', :with => 'jimmy@email.com'
  #     fill_in 'password', :with => 'password'
  #     fill_in 'password_confirmation', :with => 'password1'
  #     find(".createaccount").click
  #     find('.signup-error').text.should eq "Password doesn't match confirmation"
  #   end

  #   it "shows errors when user email already exists" do
  #     create(:fab)
  #     visit '/'
  #     click_link("Sign up")
  #     find('.signup-error').text.should eq ""
  #     sleep(1)
  #     fill_in 'name', :with => 'Fab Mackojc'
  #     fill_in 'email', :with => 'fab@gmail.com'
  #     fill_in 'password', :with => '123'
  #     fill_in 'password_confirmation', :with => '123'
  #     find(".createaccount").click
  #     find('.signup-error').text.should eq "Email has already been taken"
  #   end

  # end

  # context "User Not Logged in" do
  #   it "should not be able to see newsfeed if not logged in" do
  #     visit '/home'
  #     current_path.should eq '/'
  #     find('.error-notice').text.should eq "You are not authorized to access this page."
  #   end
  # end
end
