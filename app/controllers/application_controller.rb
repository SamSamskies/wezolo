class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery
  helper_method :current_user

  def user_followings_by_type
    @current_user_followings ||= current_user.present? ? current_user.user_followings_by_type : {}
  end

  def find_auth_provider_id(auth_provider_name)
    AuthProvider.find_by_name(auth_provider_name).id
  end

  rescue_from CanCan::AccessDenied do |exception|
    # if user is not auhorized to create a follow they are redirected to involvement page to complete profile
    if current_user.present? && exception.action == :create && exception.subject.class == Follow && current_user.auth_status == "incomplete"
      redirect_to new_involvement_path, :notice => "Please complete your profile before you can follow other users!"
    elsif current_user.present? && exception.action == :read && exception.subject.class == UserDecorator && current_user.auth_status == "incomplete"
      redirect_to new_involvement_path, :notice => "Please complete your profile before you can see other user profiles!"
    elsif current_user.present? && exception.action == :read && exception.subject == Post && current_user.auth_status == "incomplete"
      redirect_to new_involvement_path, :notice => "Please complete your profile before you can see the newsfeed!"
    else
      redirect_to root_path, :notice => exception.message
    end
  end

end
