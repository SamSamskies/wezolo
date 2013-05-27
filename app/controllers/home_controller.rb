class HomeController < ApplicationController

  def landing

  end

  def home
    authorize! :read, Post
    @newsfeed = current_user.followed_posts
  end
end
