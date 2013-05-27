class UsersController < ApplicationController
  def new
    @user = User.new
    @user.countries.build
  end

  def create
    user = User.new(email: params[:email], password: params[:password],password_confirmation: params[:password_confirmation], name: params[:name], status: params[:status].first)
    if user.save
      user.create_profile
      session[:user_id] = user.id
    else
      @error = user.errors.full_messages
      render :json => {:error => @error}, :status => :unprocessable_entity
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
