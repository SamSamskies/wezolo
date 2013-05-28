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
      if post["type"] == "text"
        blog.posts.create(:title => post["title"], :body => post["body"], :published_at => post["date"])
      elsif post["type"] == "photo"
        blog.posts.create(:body => build_photo_body(post["photos"], post["caption"]), :published_at => post["date"])
      end
    end

    redirect_to user_path(current_user)
  end

  private

  def build_photo_body(photos, caption)
    body = ""
    alt_sizes = photos.map { |photo| photo["alt_sizes"] }.flatten
    size_500 = alt_sizes.select { |photo| photo["width"] == 500 }
    urls = size_500.map { |photo| photo["url"] }
    urls.each do |url|
      body += "<img src='#{url}'>"
    end

    body += caption
  end
end
