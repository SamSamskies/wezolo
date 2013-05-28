module Authentication
  def login(user)
    set_session(user)
    redirect_to '/home'
  end

  def current_user
    @current_user ||= User.find(session[:user_id]).decorate if session[:user_id] 
  end

  def set_session(user)
    session[:user_id] = user.id
  end
end
