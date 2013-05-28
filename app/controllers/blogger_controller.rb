class BloggerController < ApplicationController
  require 'google/api_client'

  def new
  end

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
    provider = AuthProvider.find_or_create_by_name("blogger") # could write params["auth_provider"]
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
    @client.authorization.redirect_uri = 'http://localhost:3000/auth/blogger/callback'
    @client.authorization.scope = 'https://www.googleapis.com/auth/blogger.readonly'
    @auth = @client.authorization.dup
  end
end
