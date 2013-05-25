class SearchController < ApplicationController
  def index
    @users = User.all
  end

#figure out how to search by all indices
  def search_results
   # Tire.index('countries,users').search
    #   query do
    #     string (params[:search])
    #   end
    # end
    @results = Country.search(params[:search], :load => true)
    # @results = results.sort_by { |r| r._score }.reverse
    # ids = results.map(&:id)
    # @results = Country.find(results.map(&:id))
  end
end
