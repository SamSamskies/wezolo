require 'spec_helper'

describe Post do

  describe "#self.find_posts" do
    let!(:health_1_blogger) { create(:user) }
    let!(:health_1) { create(:involvement, sector: "health", :country_id => 1, user: health_1_blogger) }
    let!(:health_1_blog) { create(:blog, :user => health_1_blogger) }
    let!(:health_1_post) { create(:post, :blog => health_1_blog) }

    let!(:community_development_4_blogger) { create(:user) }
    let!(:community_development_4) { create(:involvement, sector: "community development", :country_id => 4, user: community_development_4_blogger) }
    let!(:community_development_4_blog) { create(:blog, :user => community_development_4_blogger) }
    let!(:community_development_4_post) { create(:post, :blog => community_development_4_blog) }

    context "#self.by_status" do
      let!(:ipcv_blogger) { create(:user, status: "IPCV") }
      let!(:pcv_blogger) { create(:user, status: "PCV") }
      let!(:rpcv_blogger) { create(:user, status: "RPCV") }
      it "returns the correct post given parameter to search for different statuses " do
        ipcv_blog = create(:blog, user: ipcv_blogger)
        ipcv_post = create(:post, :blog => ipcv_blog)
        ipcv_posts = Post.find_posts("Status", "IPCV")
        ipcv_posts.count.should eq(1)
        ipcv_posts.first.should eq(ipcv_post)

        pcv_blog = create(:blog, user: pcv_blogger)
        pcv_post = create(:post, :blog => pcv_blog)
        pcv_posts = Post.find_posts("Status", "PCV")
        pcv_posts.count.should eq(1)
        pcv_posts.first.should eq(pcv_post)

        rpcv_blog = create(:blog, user: rpcv_blogger)
        rpcv_post = create(:post, :blog => rpcv_blog)
        rpcv_posts = Post.find_posts("Status", "RPCV")
        rpcv_posts.count.should eq(1)
        rpcv_posts.first.should eq(rpcv_post)
      end
    end

    context "#self.by_sector" do
      it "returns the correct post given parameter to search for different sectors" do
        health_posts = Post.find_posts("Sector", "health")
        health_posts.count.should eq(1)
        health_posts.first.should eq(health_1_post)

        community_development_posts = Post.find_posts("Sector", "community development")
        community_development_posts.count.should eq(1)
        community_development_posts.first.should eq(community_development_4_post)
      end
    end

    context "#self.by_country" do
      it "returns the correct post given parameter to search for different countries" do
        1_posts = Post.find_posts("Country", "1")
        1_posts.count.should eq(1)
        1_posts.first.should eq(health_1_post)

        4_posts = Post.find_posts("Country", "4")
        4_posts.count.should eq(1)
        4_posts.first.should eq(community_development_4_post)
      end
    end
  end
end
