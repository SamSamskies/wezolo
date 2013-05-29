require 'spec_helper'

describe "Profile" do

  let!(:profile) { create(:profile) }

  it "can be seen" do
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

  it "displays the user's status" do
    page.set_rack_session(:user_id => profile.user.id)
    visit '/'
    find('.dropdown-toggle').click
    click_link("Profile")
    page.should have_content("#{profile.user.status}")
  end

  context 'edit' do
    it "should have an edit button" do
      page.set_rack_session(:user_id => profile.user.id)
      visit user_path(profile.user)
      page.should have_content("Edit")
    end

    it "shouldn't have an edit button if not logged in" do
      pending
    end

    it "should bring up the edit modal" do
      page.set_rack_session(:user_id => profile.user.id)
      visit user_path(profile.user)
      click_link("Edit")
      find('#basic-edit-info-modal')['aria-hidden'].should eq "false"
    end
  end
end
