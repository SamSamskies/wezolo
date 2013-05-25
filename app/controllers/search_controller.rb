class SearchController < ApplicationController
  def index
    @users = User.includes(:countries).all
  end

#figure out how to search by all indices
  def search_results
    @results = Country.search(params[:search], :load => true)
  end
end
