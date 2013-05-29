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

  def omniauth_failure
    flash[:notice] = "Y u no authorize?"
    redirect_to root_path
  end

  private

  def external_provider_login?
    return true if params[:auth_provider]
  end

  def find_user_by_uid
    Authorization.find_by_uid(auth["uid"]).user
  end

  def create_user_by_uid
    User.create_with_omniauth(auth)
  end

  def find_or_create_user_by_uid
    @user = find_user_by_uid || create_user_by_uid
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
      set_session(user)
      render :json => {:redirect => "/home"}
    else
      @error = "Oh Snap! User Login or Password Incorrect!"
      render :json => {:error => @error}, :status => :unprocessable_entity
    end
  end
end
