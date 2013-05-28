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
    puts "*" *
    p client.posts("nothingisweird.tumblr.com")["posts"].count
    # redirect_to user_path(current_user.id, )
    # render :json => render_to_string(:partial => 'tumblr/form', :locals => {:blogs => auth["user"]["blogs"] })
  end

  # def show
  #   conn = Faraday.new(:url => 'http://api.tumblr.com/') do |faraday|
  #     faraday.request  :url_encoded             # form-encode POST params
  #     faraday.response :logger                  # log requests to STDOUT
  #     faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  #   end
  #   conn.get "/v2/blog/peacecorps.tumblr.com/posts/text?api_key=#{ENV["TUMBLR_KEY"]}&notes_info=true"
  #   p params
  #   redirect_to root_path
  # end

  private

  def auth
    request.env["omniauth.auth"]
  end
end

# function(event, data)

#   $('#service-details-add-modal').html(data).pop()
# "http://api.tumblr.com/v2/blog/peacecorps.tumblr.com/posts/text?api_key=fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4&notes_info=true"
