require 'spec_helper'

describe "Discovery" do
  let!(:user) { create(:user, name: "justin bieber")}
  let!(:involvement) { create(:involvement, user: user) }
  let!(:profile) { create(:profile, user: user) }
  context "search" do
    it "user can be searched" do
      page.set_rack_session(:user_id => user.id)
      visit '/'
      find('#search').set("justin bieber")
      find('.fui-search').click
      page.should have_content("justin bieber")
    end

    # it "will redirect to the home page and display the login button" do
    #   page.set_rack_session(:user_id => user.id)
    #   visit '/home'
    #   find('.dropdown-toggle').click
    #   click_link("Log out")
    #   sleep(1)
    #   current_path.should eq '/'
    #   page.should have_content("Log in")
    # end
  end

end

