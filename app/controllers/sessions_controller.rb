class SessionsController < ApplicationController
  before_action :current_user, only: [:destroy]
  before_action :logged_in?, only: [:destroy]

  def new
    @user = User.new
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
