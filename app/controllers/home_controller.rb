class HomeController < ApplicationController

  def landing

  end

  def home
  	if current_user
    	@newsfeed = current_user.followed_posts
    else
    	redirect_to root_path
    end
  end
end
