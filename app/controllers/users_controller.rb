class UsersController < ApplicationController
  def new
    @user = User.new
    @user.countries.build
  end

  def create
    #refactor the form so that you don't have pass all these params
    user = User.new(email: params[:email], password: params[:password],password_confirmation: params[:password_confirmation], name: params[:name], status: params[:status].first)
    if user.save
      user.create_profile
      set_session(user)
      render :json => {:redirect => "/home"}
    else
      @error = user.errors.full_messages
      render :json => {:error => @error}, :status => :unprocessable_entity
    end
  end

  def show
    @user = User.includes(:profile, :involvements => :country).find(params[:id]).decorate

    authorize! :read, @user
  end

  def edit_password
    @user = current_user
  end

  def update_password
    current_user.change_password(params[:user])
    if current_user.errors.any?
      flash[:error] = current_user.errors.full_messages.join(", ")
    else
      flash[:notice] = "Password Change!"
    end
    redirect_to edit_password_users_path
  end

  def destroy
  end

end
