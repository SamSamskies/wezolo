class SearchController < ApplicationController
  def index
    @users = User.all
  end
  def search_results
  end
end
