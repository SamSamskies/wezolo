class SessionsController < ActionController::Base

  def create
    p params
    # session[:id] = User.find(params[:user]).id
    # redirect_to "/"
  end

  def destroy
    session.clear
  end

end
