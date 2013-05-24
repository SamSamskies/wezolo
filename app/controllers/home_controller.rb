class HomeController < ApplicationController

  def landing

  end

  def home
    #eager load this later
    @celebs = current_user.celebs    
  end
end
