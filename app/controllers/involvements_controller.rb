class InvolvementsController < ApplicationController
  load_and_authorize_resource
  def new
    @involvement = Involvement.new
  end

  def create
    @involvement = current_user.involvements.build(params[:involvement])
    if @involvement.save
      redirect_to(user_path(current_user), :notice => 'Post was successfully created.')
    else
      flash[:error] = @involvement.errors.full_messages.join(", ")
      render :action => "new"
    end
  end

  def edit
    @involvement = Involvement.find(params[:id])
  end
  
  def update
    @involvement = Involvement.find params[:id]
    
    if @involvement.update_attributes params[:involvement]
      redirect_to(user_path(current_user), :notice => 'Involvement was successfully editted.')
    else
      render :action => "new", :error => @involvement.errors.full_messages.join(", ")
    end
  end

  def destroy
    if current_user.involvements.count > 1
      Involvement.find(params[:id]).destroy
    else
      flash[:error] = "You must have service details for at least one country."
    end
    redirect_to user_path(current_user)
  end
end
