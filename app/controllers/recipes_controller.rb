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
  end

  def create
    binding.pry
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :allergen_warning, :cook_time, :category, :instructions, :type, :user_id, ingredient_attributes: [:name, :allergen_warning, :type, :measurement, :spice_level], ingredient_ids: [])
  end

end
