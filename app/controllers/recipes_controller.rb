class RecipesController < ApplicationController

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
    form_errors = Ingredient.validation_checks(params)
    if !form_errors.empty?
      redirect_to new_user_recipe_path(current_user), alert: "#{form_errors.length} ingredients already exist, but have different attributes. please review carefully."
    else
      @recipe = Recipe.create(recipe_params)
      binding.pry
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :allergen_warning, :cook_time, :category, :instructions, :user_id, ingredient_attributes: [:name, :allergen_warning, :ingredient_type, :measurement, :spice_level], ingredient_ids: [])
  end

end
