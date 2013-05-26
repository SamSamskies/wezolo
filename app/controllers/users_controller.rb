class UsersController < ApplicationController
  def new
    @user = User.new
    @user.countries.build
  end

  def create
    user = User.new(email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
    else
      flash[:error] = user.errors

    end
  end

  def show
  end

  def edit
  end

  def destroy
  end

end
