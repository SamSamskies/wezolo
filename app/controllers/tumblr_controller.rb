class TumblrController < ApplicationController
  #helpful references
  #http://behindtechlines.com/2011/08/using-the-tumblr-api-v2-on-rails-with-omniauth/
  def connect
    Tumblr.configure do |config|
      config.consumer_key = ENV["TUMBLR_KEY"]
      config.consumer_secret = ENV["TUMBLR_SECRET"]
      config.oauth_token = auth["credentials"]["token"]
      config.oauth_token_secret = auth["credentials"]["secret"]
    end
    client = Tumblr::Client.new
    @blogs = client.info["user"]["blogs"]
    provider = AuthProvider.find_or_create_by_name("tumblr") 
    current_user.authorizations << provider.authorizations.create(:token => auth["credentials"]["token"], :secret => auth["credentials"]["secret"])
  end

  def disconnect
    current_user.blogs.select { |blog| blog.url.include?("tumblr") }.first.destroy
    redirect_to user_path(current_user)
  end

  def create_blog_and_posts
    #this code is the same as the one that appears in the blogger controller
    #refactor into helper in application controller
    blog = Blog.create(params[:blog])
    blog_host = params["blog_host"]["name"]
    blog.blog_host = BlogHost.find_or_create_by_name(blog_host)
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

  def auth
    request.env["omniauth.auth"]
  end
end
