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

  def user_authorization_check_yield
    if logged_in? && current_user && (current_user.id == params[:id].to_i || current_user.admin?)
      yield
    elsif current_user.id != params[:id].to_i && !current_user.admin?
      redirect_to "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    else
      redirect_to root_path, alert: "must be logged in"
    end
  end

  def authorization_for_recipe_and_ingredient_yield
    if params[:user_id] && (params[:user_id].to_i == current_user.id || current_user.admin?)
      yield
    elsif params[:user_id] && params[:user_id].to_i != current_user.id && !current_user.admin?
      redirect_to "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    else
      @recipes = Recipe.all
    end
  end

  def logged_in_yield
    if logged_in? && current_user
      yield
    else
      redirect_to :back, alert: "must be logged in" #can encapsulate this alert message in a method
    end
  end

end
