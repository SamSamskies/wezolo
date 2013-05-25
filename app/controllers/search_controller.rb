class SearchController < ApplicationController
  def index
    @users = User.all
  end

#figure out how to search by all indices
  def search_results
   # Tire.index('countries,users').search
    #   query do
    #     string (params[:search])
    @results = Country.search(params[:search], :load => true)
  end
end
