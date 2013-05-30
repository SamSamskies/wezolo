class ProfilesController < ApplicationController
  load_and_authorize_resource
  def edit
    @profile = Profile.find(params[:id])
  end
  
  def update
    profile = Profile.find(params[:id])
    profile.update_attributes(params[:profile])
    redirect_to user_path(profile.user)
  end
  
end
