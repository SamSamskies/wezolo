require 'spec_helper'

describe Blog do

  let!(:fanguy) { create(:user, :name => "fanguy") }
  
  let!(:blogger) { create(:blog_host) }

  let!(:blog) { create(:blog) }

  let!(:post1) { create(:post) }
  let!(:post2) { create(:post) }
  let!(:post3) { create(:post) }

  it "has a user" do
    blog.user =  fanguy
    blog.save
    blog.reload
    blog.user.should eq fanguy
  end

  it "has a blog host" do
    blog.blog_host = blogger
    blog.save
    blog.reload
    blog.blog_host.should eq blogger
  end

  it "can have multiple blog posts" do
    blog.posts << post1 
    blog.posts << post2
    blog.posts << post3
    blog.posts.count.should eq 3
    blog.posts.should eq [post3, post2, post1]
  end

end
