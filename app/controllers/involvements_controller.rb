class InvolvementsController < ApplicationController

  def new
    @involvement = Involvement.new
  end

  def create
    @involvement = current_user.involvements.build(params[:involvement])
    if @involvement.save
      redirect_to(user_path(current_user), :notice => 'Post was successfully created.')
    else
      render :action => "new", :error => @involvement.errors.full_messages.join(", ")
    end
  end

  
  def update
  end

  def destroy
  end
end
