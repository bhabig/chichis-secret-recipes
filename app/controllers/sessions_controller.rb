class SessionsController < ApplicationController
  before_action :current_user, only: [:destroy]
  before_action :logged_in?, only: [:destroy]

  def new
    if current_user
      redirect_to user_path(@user), alert: "you are already signed in. you must sign out before signing into a different account."
    else
      @user = User.new
    end
  end

  def facebook
    omni_hash = request.env["omniauth.auth"]
    user = User.find_or_create_by_omniauth(omni_hash)
    session[:user_id] = user.try(:id)
    redirect_to root_path
  end

  def create
    @user = User.where("lower(name) = ?", params[:user][:name].downcase).first
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_session_path, alert: "information provided invalid"
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  def auth
   request.env['omniauth.auth']
  end

end
