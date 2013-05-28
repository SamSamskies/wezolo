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
    # redirect_to user_path(current_user.id)
  end

  def disconnect
    current_user.blogs.select { |blog| blog.url.include?("tumblr") }.first.destroy
    redirect_to user_path(current_user)
  end

  private

  def auth
    request.env["omniauth.auth"]
  end
end
