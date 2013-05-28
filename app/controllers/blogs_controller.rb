class BlogsController < ApplicationController

  def create
    blog = Blog.create(params[:blog])
    blog.blog_host = BlogHost.find_or_create_by_name(params["blog_host"]["name"])
    blog.save!
    current_user.blogs << blog

    tumblr_id = find_auth_provider_id("tumblr")
    Tumblr.configure do |config|
      config.oauth_token = current_user.authorizations.select{|a| a.auth_provider_id == tumblr_id}.first.token
      config.oauth_token_secret = current_user.authorizations.select{|a| a.auth_provider_id == tumblr_id}.first.secret
    end

    client = Tumblr::Client.new
    @posts = client.posts(blog.url.gsub("http://", ""))["posts"]
    @posts.each do |post| 
      post["body"] = "null" unless post["body"]
      blog.posts.create(:title => post["title"], :body => post["body"])
    end
    p blog.posts



    redirect_to user_path(current_user)
  end
end
