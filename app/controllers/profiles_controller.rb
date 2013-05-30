class ProfilesController < ApplicationController
  load_and_authorize_resource
  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    profile = Profile.find(params[:id])
    format_phone_number
    profile.update_attributes(params[:profile])
    redirect_to user_path(profile.user)
  end

  private

  def format_phone_number
    params[:profile][:user_attributes][:phone_number] = "+" + PhonyRails.normalize_number(params[:profile][:user_attributes][:phone_number])
  end
end
