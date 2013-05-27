class FollowsController < ApplicationController
  load_and_authorize_resource
  def create
    Follow.create(follow_params)
    redirect_to search_index_path
  end

  def destroy
    Follow.where(follow_params).destroy_all
    redirect_to search_index_path
  end

  def follow_params
    {followable_id: params[:followable_id], followable_type: params[:followable_type], follower_id: current_user.id}
  end
end
