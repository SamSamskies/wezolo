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
    @involvement = current_user.involvements.build(params[:involvement])
    if @involvement.save
      redirect_to(user_path(current_user), :notice => 'Involvement was successfully editted.')
    else
      render :action => "new", :error => @involvement.errors.full_messages.join(", ")
    end
  end

  def destroy
  end
end
