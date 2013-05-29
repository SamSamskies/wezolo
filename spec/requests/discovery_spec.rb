require 'spec_helper'

describe "Discovery" do
  context "search" do
    before do
      User.index.delete
      User.index.create
      User.index.refresh
    end
    it "user can be searched" do
      user = create(:user, name: "justin bieber")
      country = create(:country, name: "country")
      involvement = create(:involvement, user: user, country: country)
      profile = create(:profile, user: user)
      page.set_rack_session(:user_id => user.id)
      visit '/'
      find('#search').set("justin bieber")
      find('.fui-search').click
      save_page
      page.should have_content("justin bieber")
    end
  end

end

