class HomeController < ApplicationController
  QUERY_TYPES = ["country", "sector", "status", "follow", "all"]
  caches_action :landing, :expires_in => 2.hours
  caches_action :home, :cache_path => proc {|c| "#{c.params[:query_string]}_#{c.params[:query_type]}"}, :if => proc { params[:query_type] && params[:query_string] }
  cache_sweeper :post_sweeper

  def landing
  end

  def home
    authorize! :read, Post
    if params[:query_type] == nil || !QUERY_TYPES.include?(params[:query_type])
      @newsfeed = current_user.followed_posts({:page => params[:page], :per_page => 10})
    else
      @newsfeed = Post.find_posts(params[:query_type], params[:query_string], {:page => params[:page], :per_page => 10})
    end
  end

  def about
  end
end

