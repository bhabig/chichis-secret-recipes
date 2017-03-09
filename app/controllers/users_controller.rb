class UsersController < ApplicationController

  def new
    if current_user || admin?
      redirect_to user_path(@user), alert: "you are already signed in. you must sign out before creating a new account."
    else
      @user = User.new
    end
  end

  def create
    if password? && matching_password? #turn into yield method
      @user = User.new(user_params)
      @user.standardize_name
      if @user.save
        session[:user_id].to_i = @user.id
        redirect_to user_path(@user)
      else
        render :new
      end
    else
      redirect_to new_user_path, alert: "passwords must match and cannot be left blank"
    end
  end

  def show
    binding.pry
    if logged_in? && current_user && (current_user.id == params[:id].to_i || current_user.admin?)#turn into private method & use before_action
      render :show
    elsif current_user.id != params[:id].to_i && !current_user.admin?
      session.clear
      redirect_to root_path, alert: "not authorized. please sign back in to your own account"
    else
      redirect_to root_path, alert: "must be logged in to see this page"
    end
  end

  def edit #turn into private method & use before_action
    if logged_in? && current_user && (current_user.id == params[:id].to_i || current_user.admin?)
      render :edit
    else
      redirect_to root_path, alert: "must be logged in to see this page"
    end
  end

  def update
    if check_password
      @user.update(user_params)
      @user.standardize_name
      if @user.save
        redirect_to root_path
      else
        render :edit
      end
    end
  end

  def destroy
    if logged_in? && current_user && (current_user.id == params[:id].to_i || current_user.admin?)
      user = User.find_by(id: params[:id].to_i)
      if user && user == current_user
        user.destroy
        redirect_to root_path, alert: "account deleted succesfully"
        session.clear
      end
    else
      redirect_to :back, alert: "must be logged in to delete an account"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
