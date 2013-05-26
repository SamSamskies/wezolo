class UsersController < ApplicationController
  def new
    @user = User.new
    @user.countries.build
  end

  def create
    user = User.new(email: params[:email], password: params[:password], name: params[:name], )
    if user.save
      session[:user_id] = user.id
    else
      flash[:error] = user.errors
    end
  end

  def show
    @user = User.includes(:profile, :involvements => :country).find(params[:id]).decorate
  end

  def edit
  end

  def destroy
  end

end
