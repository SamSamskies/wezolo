class TumblrController < ApplicationController
  #helpful references
  #http://behindtechlines.com/2011/08/using-the-tumblr-api-v2-on-rails-with-omniauth/
  def new
    Tumblr.configure do |config|
      config.consumer_key = ENV["TUMBLR_KEY"]
      config.consumer_secret = ENV["TUMBLR_SECRET"]
      config.oauth_token = auth["credentials"]["token"]
      config.oauth_token_secret = auth["credentials"]["secret"]
    end
    client = Tumblr::Client.new
    @blogs = client.info["user"]["blogs"]
    # redirect_to user_path(current_user.id, )
    # render :json => render_to_string(:partial => 'tumblr/form', :locals => {:blogs => auth["user"]["blogs"] })
  end


private

  def auth
    request.env["omniauth.auth"]
  end
end

# function(event, data)
  
#   $('#service-details-add-modal').html(data).pop()
