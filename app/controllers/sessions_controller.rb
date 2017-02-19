class SessionsController < ApplicationController
  before_action :current_user, only: [:destroy]
  before_action :logged_in?, only: [:destroy]
  def new
    @user = User.new
  end

  def create
    binding.pry
    
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end
