class SearchController < ApplicationController
  def index
    @users = User.all
  end
end
