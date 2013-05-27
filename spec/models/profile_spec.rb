require 'spec_helper'

describe Profile do

  it "gets created after a user is created" do
    pending
  end

  it "gets deleted after user is deleted - dependency"

  # context "search indexing" do
  #   let!(:user) { create(:user, name: "supermaniscrazy") }
  #   it "on save #update_user_index" do
  #     user.create_profile(bio: "not he is not")
  #     p User.search(search: "supermaniscrazy")
  #   end
  # end
end

# User.search(search: "sam")
# u = User.search(search: "sam")[0]
# u.profile.update_attributes(bio: "fdasfdsafdsadssfdas")
# User.search(search: "sam")
