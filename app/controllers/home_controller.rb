class HomeController < ApplicationController
  QUERY_TYPES = ["country", "sector", "status", "follow", "all"]

  def landing

  end

  def home
    authorize! :read, Post
    if params[:query_type] == nil
      @newsfeed = current_user.followed_posts
    else
      @newsfeed = Post.find_posts(params[:query_type], params[:query_string])
    end
  end

  # Review: Remove this if it's cruft. Avoid commiting empty methods like this.
  def valid_query?

  end
end
