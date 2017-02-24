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

end
