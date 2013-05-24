class UsersController < ApplicationController
  def new
    @user = User.new
    @user.countries.build
  end

  def create
    user = User.new(params[:user])
    user.countries << Country.find(params[:country_id])
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
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
