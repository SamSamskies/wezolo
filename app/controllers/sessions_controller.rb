class SessionsController < ActionController::Base

  def new
    p params
    # session[:id] = User.find(params[:user]).id
    # redirect_to "/"
  end

  def destroy
    session.clear
  end

end
