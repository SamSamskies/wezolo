class SessionController < ApplicationController

  def create
    if external_provider_login?
      authenticate_user_by_external_provider
    else
      authenticate_user_by_email
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

  def auth
    request.env["omniauth.auth"]
  end

  def external_provider_login?
    defined?(params[:auth_provider])
  end

  def authenticate_user_by_external_provider
    user = User.find_by_email(auth["info"]["email"])
    if user
      Authorization.find_or_create_by_uid(auth, user)
    else
      user = User.create_with_omniauth(auth)
    end
    login(user)
  end

  def authenticate_user_by_email
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      login(user)
    else
      @error = "Oh Snap! User Login or Password Incorrect!"
      render :json => {:error => @error}, :status => :unprocessable_entity
    end
  end
end
