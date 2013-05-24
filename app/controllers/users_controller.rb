class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect_to "/"
    else
      flash[:error] = "hello"
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def destroy
  end

end
