class BlogsController < ApplicationController

  def create
    blog = Blog.create(params[:blog])
    blog_host = params["blog_host"]["name"]
    blog.blog_host = BlogHost.find_or_create_by_name(blog_host)
    blog.save!
    current_user.blogs << blog

    if blog_host == "tumblr"
      Tumblr.configure do |config|
        config.oauth_token = current_user.authorizations.select{|a| a.auth_provider_id == 5}.first.token
        config.oauth_token_secret = current_user.authorizations.select{|a| a.auth_provider_id == 5}.first.secret
      end
      client = Tumblr::Client.new
      @posts = client.posts(blog.url.gsub("http://", ""))["posts"]
      @posts.each do |post| 
        post["body"] = "null" unless post["body"]
        blog.posts.create(:title => post["title"], :body => post["body"])
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

      redirect_to user_path(current_user)
    end
  end
end
