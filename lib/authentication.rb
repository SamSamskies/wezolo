module Authentication
  def login(user)
    session[:id] = user.id
    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
