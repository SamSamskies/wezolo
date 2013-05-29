class FollowsController < ApplicationController
  load_and_authorize_resource
  def create
    # Review: Consider what will happen if the create fails to save a follow. Follow.create! will throw
    # and exception or you can check the return value (true/false) of Follow.create
    Follow.create(follow_params)
    redirect_to :back
  end

  def destroy
    # Review: Any reason you can't send up the id of the Follow record you're going to delete? Searching
    # for a Follow record based on the :followable_id, :followable_type and :follower_id is obtuse.
    Follow.where(follow_params).destroy_all
    redirect_to :back
  end

  def follow_params
    {followable_id: params[:followable_id], followable_type: params[:followable_type], follower_id: current_user.id}
  end
end
