require 'spec_helper'

describe UserDecorator do


  context "#follow_link" do
    let!(:justin_bieber) { create(:user, :name => "justin bieber")}
    let!(:usa) { create(:country, :name => "usa") }
    let!(:fan) { create(:user, :name => "fan") }
    it "can see follow link if they have not followed the obj" do
      pending
      # fan.heroes << justin_bieber
      # fan.following_countries << usa
      # decorated_fan = fan.decorate
      # decorated_fan.follow_link(usa).should eq(2)
    end
  end
end
