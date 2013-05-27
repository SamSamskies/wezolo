module Authentication
  def login(user)
    session[:user_id] = user.id
    redirect_to '/home'
  end

  def current_user
    @current_user ||= User.find(session[:user_id]).decorate if session[:user_id] 
  end
end
