Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"],
    {:scope => "userinfo.email,userinfo.profile",
     :approval_prompt => "auto"}
  provider :tumblr, ENV['TUMBLR_KEY'], ENV['TUMBLR_SECRET']
end
