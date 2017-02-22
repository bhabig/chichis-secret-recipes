class WelcomeController < ApplicationController
  before_action :current_user

  def welcome
    if current_user
      redirect_to user_path(current_user)
    else
      render :welcome
    end
  end
end
