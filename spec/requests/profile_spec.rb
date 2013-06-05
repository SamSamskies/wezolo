require 'spec_helper'

describe "Profile" do

  let!(:profile) { create(:profile) }
  let!(:interested_user) { create(:user, :status => "interested") }
  let!(:interested_profile) { create(:profile, :user => interested_user) }

  let!(:return_volunteer) { create(:user, :status => "rpcv") }
  let!(:returned_profile) { create(:profile, :user => return_volunteer) }
  let!(:spain) { create(:country, name: "spain") }
  let!(:involvement) { create(:involvement, :user => return_volunteer, :country => spain) }

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
    page.should have_content("#{User.statuses_hash[profile.user.status]}")
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

    it "edit should be able to edit service details" do
      page.set_rack_session(:user_id => return_volunteer.id)
      visit user_path(return_volunteer)
      within("#service-details.span7"){ click_link("Edit") }
      fill_in('Description', :with=> "wezolo sam i love you")
      within("div#service-details-edit-modal-0") { find('.btn').click }
      page.should have_content("wezolo sam i love you")
    end
  end

  context 'completing the profile' do
    it "interested user should be directed to the what's going on page" do
      page.set_rack_session(:user_id => interested_user.id)
      visit '/'
      find('.dropdown-toggle').click
      click_link("What's Going On?")
      page.should have_content("What's Going On?")
    end
    it "interested user should not be able to see add service detail" do
      page.set_rack_session(:user_id => interested_user.id)
      visit '/'
      find('.dropdown-toggle').click
      click_link("Profile")
      page.should_not have_content("Service Details")
    end
  end
end
