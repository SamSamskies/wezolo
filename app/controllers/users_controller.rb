class UsersController < ApplicationController
  def new
    @user = User.new
    @user.countries.build
  end

  def create
    user = User.new(params[:user])
    #delete_if is used because there is a bug in collection select that adds a blank ""
    countries = params[:country_ids].delete_if(&:empty?).map{|id| Country.find(id)}
    user.countries << countries
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = user.errors
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
