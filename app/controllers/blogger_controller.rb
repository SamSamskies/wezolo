class BloggerController < ApplicationController
  require 'google/api_client'

  def request_blogger_access
    user_credentials
    redirect_to user_credentials.authorization_uri.to_s
  end

  def authorize_blogger
    user_credentials.code = params[:code] if params[:code]
    @auth.fetch_access_token!
    session[:access_token] = @auth.access_token
    session[:refresh_token] = @auth.refresh_token
    session[:expires_in] = @auth.expires_in
    session[:issued_at] = @auth.issued_at
    provider = AuthProvider.find_or_create_by_name("blogger")
    current_user.authorizations << provider.authorizations.create(:token => @auth.access_token, :secret => @auth.refresh_token)
    response = @client.execute(:api_method => @blogger.blogs.list_by_user,
      :parameters => {"userId" => 'self'},
      :authorization => @auth)
    @blogs = response.data.items

  end

  def user_credentials
    @client = Google::APIClient.new
    @blogger = @client.discovered_api('blogger', 'v3')
    @client.authorization.client_id = ENV["BLOGGER_CLIENT_ID"]
    @client.authorization.client_secret = ENV["BLOGGER_CLIENT_SECRET"]
    puts "#{root_url}auth/blogger/callback"
    @client.authorization.redirect_uri = "#{root_url}auth/blogger/callback"
    @client.authorization.scope = 'https://www.googleapis.com/auth/blogger.readonly'
    @auth = @client.authorization.dup
  end

  def create_blog_and_posts
    #refactor this into helper see repetition in tumblr controller
    blog = Blog.create(params[:blog])
    blog_host = params["blog_host"]["name"]
    blog.blog_host = BlogHost.find_or_create_by_name(blog_host)
    blog.save!
    current_user.blogs << blog
    #dont refactor

    @blogId = blog.external_id
    @client = Google::APIClient.new
    @blogger = @client.discovered_api('blogger', 'v3')

    # Initialize OAuth 2.0 @client
    @client.authorization.client_id = ENV["BLOGGER_CLIENT_ID"]
    @client.authorization.client_secret = ENV["BLOGGER_CLIENT_SECRET"]
    @client.authorization.redirect_uri = "#{root_url}auth/blogger/callback"
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

  def disconnect
    disconnect_blog("blogger")
  end

end
