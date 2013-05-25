class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery
  helper_method :current_user

  def user_followings_by_type
    @current_user_followings ||= current_user.present? ? current_user.user_followings_by_type : {}
  end

end
