class ProfilesController < ApplicationController
  load_and_authorize_resource :except => :avatar_upload
  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    profile = Profile.find(params[:id])
    format_phone_number unless params[:profile][:user_attributes][:phone_number] == ""
    profile.update_attributes(params[:profile])
    redirect_to user_path(profile.user)
  end

  def avatar_upload
    profile = User.find(current_user.id).profile
    profile.update_attributes(:photo_url => params[:url])
    render :nothing => true, :status => :ok
  end

  private

  def format_phone_number
    params[:profile][:user_attributes][:phone_number] = "+" + PhonyRails.normalize_number(params[:profile][:user_attributes][:phone_number])
  end
end
