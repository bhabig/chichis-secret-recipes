class UsersController < ApplicationController
  before_action :logged_in?, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    if password? && matching_password?
      @user = User.new(user_params)
      @user.standardize_name
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        render :new
      end
    else
      redirect_to new_user_path, alert: "passwords must match and cannot be left blank"
    end
  end

  def show
  end

  def edit
  end

  def update
    if check_password
      @user.update(user_params)
      @user.standardize_name
      if @user.save
        redirect_to user_path(@user)
      else
        render :edit
      end
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user && user == current_user
      session.clear
      user.destroy
      redirect_to root_path, alert: "account deleted succesfully"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def matching_password?
    params[:user][:password] == params[:user][:password_confirmation]
  end

  def check_password
    !params[:user][:password].nil? && !params[:user][:password_confirmation].nil?
  end
end
