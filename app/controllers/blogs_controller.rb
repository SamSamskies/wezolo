class BlogsController < ApplicationController
  def tumblr
    Tumblr.configure do |config|
      config.consumer_key = ENV["TUMBLR_KEY"]
      config.consumer_secret = ENV["TUMBLR_SECRET"]
      config.oauth_token = auth["credentials"]["token"]
      config.oauth_token_secret = auth["credentials"]["secret"]
    end
    client = Tumblr::Client.new

    p client.info
    p request.env["omniauth.auth"]
    redirect_to :root
  end

private

  def auth
    request.env["omniauth.auth"]
  end
end
