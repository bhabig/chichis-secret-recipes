class LikesController < ApplicationController

  def index
  end

  def create_or_update
    @like = Like.find_by(like_params)
    if @like
      @like.update(like_params)
      @like.save
      render json: @like
    else
      @like = Like.create(like_params)
      render json: @like, status: 201
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :recipe_id, :status)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
