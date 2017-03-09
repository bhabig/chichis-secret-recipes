class SessionsController < ApplicationController
  before_action :current_user, only: [:destroy]
  before_action :logged_in?, only: [:destroy]

  def new
    if logged_in? && current_user #maybe make a yield in ApplicationController
      redirect_to user_path(@user), alert: "you are already signed in. you must sign out before signing into a different account."
    else
      @user = User.new
    end
  end

  def create
    set_user(params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_session_path, alert: "could not log in with given credentials"
    end
  end

  def facebook #refactor?
    facebook_auth_check do
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        redirect_to new_session_path, alert: "could not log user in"
      end
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  def auth
   request.env['omniauth.auth']
  end

  private

  def set_user(params)
    @user = User.where("lower(name) = ?", params.downcase).first
  end

  private

  def facebook_auth_check
    if auth
      @user = User.find_or_create_by_omniauth(auth)
      yield
    else
      redirect_to new_session_path, alert: "could not log user in"
    end
  end

end
