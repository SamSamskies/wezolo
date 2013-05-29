require 'spec_helper'

describe Post do

  describe "#self.find_posts" do
    let!(:health_1_blogger) { create(:user, status: "interested") }
    let!(:health_1) { create(:involvement, sector: "health", :country_id => 1, user: health_1_blogger) }
    let!(:health_1_blog) { create(:blog, :user => health_1_blogger) }
    let!(:health_1_post) { create(:post, :blog => health_1_blog) }

    let!(:community_development_4_blogger) { create(:user, status: "interested") }
    let!(:community_development_4) { create(:involvement, sector: "community development", :country_id => 4, user: community_development_4_blogger) }
    let!(:community_development_4_blog) { create(:blog, :user => community_development_4_blogger) }
    let!(:community_development_4_post) { create(:post, :blog => community_development_4_blog) }

    let!(:ipcv_blogger) { create(:user, status: "ipcv") }
    let!(:pcv_blogger) { create(:user, status: "pcv") }
    let!(:rpcv_blogger) { create(:user, status: "rpcv") }
    let!(:ipcv_blog) { create(:blog, user: ipcv_blogger)}
    let!(:ipcv_post) { create(:post, :blog => ipcv_blog, title: "ipcv post}")}
    let!(:pcv_blog ) {create(:blog, user: pcv_blogger)}
    let!(:pcv_post ) {create(:post, :blog => pcv_blog, title: "pcv post")}
    let!(:rpcv_blog) { create(:blog, user: rpcv_blogger)}
    let!(:rpcv_post) { create(:post, :blog => rpcv_blog, title: "pcv post")}

    context "#self.by_status" do
      it "returns one ipcv post" do
        ipcv_posts = Post.find_posts("status", "ipcv")
        ipcv_posts.count.should eq(1)
        ipcv_posts.first.should eq(ipcv_post)
      end

      it "returns one pcv post " do
        pcv_posts = Post.find_posts("status", "pcv")
        pcv_posts.count.should eq(1)
        pcv_posts.first.should eq(pcv_post)
      end

      it "returns one rpcv post " do
        rpcv_posts = Post.find_posts("status", "rpcv")
        rpcv_posts.count.should eq(1)
        rpcv_posts.first.should eq(rpcv_post)
      end

      it "still returns the correct results with up or downcases"
    end

    context "#self.by_sector" do
      it "returns the correct post given parameter to search for health sector" do
        health_posts = Post.find_posts("sector", "health")
        health_posts.count.should eq(1)
        health_posts.first.should eq(health_1_post)
      end

      it "returns the correct post given parameter to search for community development sector" do
        community_development_posts = Post.find_posts("sector", "community development")
        community_development_posts.count.should eq(1)
        community_development_posts.first.should eq(community_development_4_post)
      end
    end

    context "#self.by_country" do
      it "returns the correct post given when we are searching for country one" do
        country_one_posts = Post.find_posts("country", "1")
        country_one_posts.count.should eq(1)
        country_one_posts.first.should eq(health_1_post)
      end
      it "returns the correct post given when we are searching for country four" do
        country_four_posts = Post.find_posts("country", "4")
        country_four_posts.count.should eq(1)
        country_four_posts.first.should eq(community_development_4_post)
      end
    end
  end
end
