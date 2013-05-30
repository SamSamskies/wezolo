class SearchController < ApplicationController
  # caches_action :index, :layout => false, :cache_path => proc { current_user.id }
    
  def index
    @users = User.includes({:involvements => :country}, :profile).all
  end

#figure out how to search by all indices
  def search_results
    @results = User.search(params[:search])
  end

end
