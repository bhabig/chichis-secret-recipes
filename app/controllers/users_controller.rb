class UsersController < ApplicationController

  def new
    if logged_in? && current_user #maybe make a yield in ApplicationController
      redirect_to user_path(@user), alert: "you are already signed in. you must sign out before creating a new account."
    else
      @user = User.new
    end
  end

  def create
    create_user_yield do 
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        render :new
      end
    end
  end

  def show #yield + refactor
    user_authorization_check_yield#turn into private method & use before_action
      render :show
    end
  end

  def edit #yield + refactor
    user_authorization_check_yield do
      render :edit
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

  def destroy #yield + refactor
    user_authorization_check_yield do
      user = User.find_by(id: params[:id].to_i)
      if user && user == current_user
        user.destroy
        redirect_to root_path, alert: "account deleted succesfully"
        session.clear
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def create_user_yield
    if password? && matching_password?
      @user = User.new(user_params)
      @user.standardize_name
      yield
    else
      redirect_to new_user_path, alert: "passwords must match and cannot be left blank"
    end
  end

end