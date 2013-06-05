class FollowsController < ApplicationController
  load_and_authorize_resource
  def create
    @follow = Follow.new(follow_params)
    if @follow.save
      render :json => {:link => current_user.unfollow_link_widget(follow_params)}
    else
      render :json => @follow.errors.full_messages.join(", "), :status => :unprocessable_entity
    end
  end

  def destroy
    Follow.where(follow_params).destroy_all
    render :json => {:link => current_user.follow_link_widget(follow_params)}
  end

  def follow_params
    {followable_id: params[:followable_id], followable_type: params[:followable_type], follower_id: current_user.id}
  end
end
