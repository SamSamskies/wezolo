class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery
  helper_method :current_user
end
