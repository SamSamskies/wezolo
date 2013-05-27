class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery
  helper_method :current_user

  def user_followings_by_type
    @current_user_followings ||= current_user.present? ? current_user.user_followings_by_type : {}
  end

  rescue_from CanCan::AccessDenied do |exception|
    # if user is not auhorized to create a follow they are redirected to involvement page to complete profile
    if exception.action == :create && exception.subject.class == Follow
      redirect_to new_involvement_path, flash[:notice] => exception.message
    else
      redirect_to root_path
    end
  end

end
