class FollowsController < ApplicationController
  def create
    Follow.create(followable_id: params[:followable_id], followable_type: params[:followable_type], follower_id: current_user.id)
    redirect_to search_index_path
  end

  def destroy
    Follow.where(followable_type: params[:followable_type], followable_id: params[:followable_id], follower_id: current_user.id).first.destroy
    redirect_to search_index_path
  end
end
