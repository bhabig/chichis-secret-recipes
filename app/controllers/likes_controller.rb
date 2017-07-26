class LikesController < ApplicationController

  def index
  end

  def create_or_update
    binding.pry
    render json: @like, status: 201
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :recipe_id)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
