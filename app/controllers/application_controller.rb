class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user
  before_action :logged_in?, only: [:new, :create, :edit, :update, :destroy]

  private

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end

  def password?
    params[:user][:password] || !params[:user][:password].nil?
  end

  def matching_password?
    params[:user][:password] == params[:user][:password_confirmation]
  end

  def check_password
    !params[:user][:password].nil? && !params[:user][:password_confirmation].nil?
  end

end
