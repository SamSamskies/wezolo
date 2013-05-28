class BloggerController < ApplicationController
  require 'google/api_client'

  def step1

    # auth.code = ''
    # auth.fetch_access_token!

    # response = client.execute(:api_method => blogger.posts.list,
    #   :parameters => {"blogId" => "16879703"},
    #   :auth => auth)
    user_credentials
    p user_credentials.authorization_uri.to_s
    p user_credentials
    # p response
    # p response.data

    redirect_to user_credentials.authorization_uri.to_s
  end

  def step2
    user_credentials.code = params[:code] if params[:code]
    @auth.fetch_access_token!
    response = @client.execute(:api_method => @blogger.posts.list,
      :parameters => {"blogId" => "16879703", "prettyPrint" => true},
      :authorization => @auth)
    puts "**********"
    puts response
    puts response.inspect
    puts response.methods
    puts response.data
    puts response.data.methods
    puts "howdy//................................"
    puts response.data.items
    puts response.data.items.first.content
    redirect_to ('/')
  end

  def user_credentials
    @client = Google::APIClient.new
    @blogger = @client.discovered_api('blogger', 'v3')

    # Initialize OAuth 2.0 @client
    @client.authorization.client_id = '584173826906.apps.googleusercontent.com'
    @client.authorization.client_secret = 'gsxulxyKi3M0Ej6lzy4F9gnH'
    @client.authorization.redirect_uri = 'http://localhost:3000/oauth2authorize'

    @client.authorization.scope = 'https://www.googleapis.com/auth/blogger'

    redirect_uri = @client.authorization.authorization_uri

    @auth = @client.authorization.dup
  end

end