class SearchController < ApplicationController
  def index
    @users = User.includes({:involvements => :country}, :profile).all
  end

#figure out how to search by all indices
  def search_results
    @results = User.search(params[:search])
  end
end
