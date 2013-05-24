class HomeController < ApplicationController

  def landing

  end

  def home
    #eager load this later
    @all_post = current_user.followed_posts
  end
end
