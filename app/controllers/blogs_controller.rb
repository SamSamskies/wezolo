class BlogsController < ApplicationController

  def create
    blog = Blog.create(params[:blog])
    blog_host = params["blog_host"]["name"]
    blog.blog_host = BlogHost.find_or_create_by_name(blog_host)
    blog.save!
    current_user.blogs << blog

    if blog_host == "tumblr"
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
    elsif blog_host == "blogger"
      @blogId = blog.external_id
      @client = Google::APIClient.new
      @blogger = @client.discovered_api('blogger', 'v3')

      # Initialize OAuth 2.0 @client
      @client.authorization.client_id = ENV["BLOGGER_CLIENT_ID"]
      @client.authorization.client_secret = ENV["BLOGGER_CLIENT_SECRET"]
      @client.authorization.redirect_uri = 'http://localhost:3000/auth/blogger/callback'
      @client.authorization.scope = 'https://www.googleapis.com/auth/blogger.readonly'
      @auth = @client.authorization.dup

      @auth.update_token!(session)

      response = @client.execute(:api_method => @blogger.posts.list,
        :parameters => {"blogId" => @blogId},
        :authorization => @auth)

      @posts = response.data.items
      @posts.each do |post| 
        blog.posts.create(:title => post["title"], :body => post["content"], :published_at => post["published"])
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
