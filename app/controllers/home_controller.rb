class HomeController < ApplicationController

  def landing

  end

  def home
    @newsfeed = current_user.followed_posts
  end
end
