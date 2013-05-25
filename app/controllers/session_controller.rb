class SessionController < ApplicationController

  def create
    if external_provider_login?
      user = User.find_by_email(auth["info"]["email"])
      if user
        Authorization.find_or_create_by_uid(auth, user)
      else
        user = User.create_with_omniauth(auth)
      end
      login(user)
    else
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        login(user)
      else
        flash[:notice] = "Invalid email or password"
        redirect_to root_url
      end
    end
  end

  def destroy
    session.clear
    redirect_to root_url
  end

  def omniauth_failure # need to add this to routes.rb?
    flash[:notice] = "Y u no authorize?"
    redirect_to root_path
  end

  private

  def find_user_by_uid
    Authorization.find_by_uid(auth["uid"]).user
  end

  def create_user_by_uid
    User.create_with_omniauth(auth) # how does this work?
  end

  def find_or_create_user_by_uid
    @user = find_user_by_uid || create_user_by_uid
  end

  def auth
    request.env["omniauth.auth"]
  end

  def external_provider_login?
    return true if params[:auth_provider] 
  end

end
