class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in!"
      redirect_to home_path
    else
      flash[:notice] = "Invalid email or password"
      redirect_to root_url
    end

  end

  def destroy
    session.clear
    redirect_to root_url
  end

end
