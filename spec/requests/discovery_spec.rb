require 'spec_helper'

describe "Discovery" do
  context "search" do
    it "user can be searched" do
      User.index.delete
      User.index.create
      user = create(:user, name: "justin bieber")
      country = create(:country, name: "country")
      involvement = create(:involvement, user: user, country: country)
      profile = create(:profile, user: user)
      User.index.refresh
      page.set_rack_session(:user_id => user.id)
      visit '/'
      find('#search').set("justin bieber")
      find('.fui-search').click
      save_page
      page.should have_content("justin bieber")
    end
  end

end

