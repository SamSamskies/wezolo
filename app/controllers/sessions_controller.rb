class SessionsController < ApplicationController

  def create
    p params
    p current_user
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      p "signedin!"
      flash[:notice] = "Logged in!"
      redirect_to root_url
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
