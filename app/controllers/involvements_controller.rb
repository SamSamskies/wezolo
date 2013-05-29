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
      # Review: Where is the value of :error used? If you want to expose the errors for a model
      # it's more typical to access @model.errors in your view, not manipulate the list of errors
      # in your controller.
      render :action => "new", :error => @involvement.errors.full_messages.join(", ")
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

  # Review: Not implemented? Remove it.
  def destroy
  end
end
