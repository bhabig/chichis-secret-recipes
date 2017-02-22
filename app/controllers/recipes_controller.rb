class RecipesController < ApplicationController
  before_action :current_user

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @recipes = @user.recipes
      redirect_to user_recipes_path(@user)
    else
      @recipes = Recipe.all
      redirect_to recipes_path
    end
  end

  def new
    @recipe = @user.recipes.build
    10.times{@recipe.ingredients.biuld}
  end

end
