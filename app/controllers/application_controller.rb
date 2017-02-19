class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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

end
