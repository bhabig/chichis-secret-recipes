class RecipesController < ApplicationController

  def index
    if current_user && logged_in?
      @recipes = current_user.recipes unless current_user.recipes.empty?
    else
      @recipes = Recipe.all
    end
  end

  def new
    @recipe = @user.recipes.build
  end

  def create
    name_errors = Ingredient.validation_checks(params)
    if !name_errors.empty?
      redirect_to new_user_recipe_path(current_user), alert: "#{name_errors.length} ingredients already exist, but have different attributes. please review carefully."
    else
      other_errors = Ingredient.attribute_checks(params)
      if other_errors.empty?
        @recipe = Recipe.create(recipe_params)
        redirect_to user_recipe_path(@recipe.user_id, @recipe)
      else
        redirect_to new_user_recipe_path(current_user), alert: "#{other_errors.length} ingredient forms had 1 or more empty fields."
      end
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :allergen_warning, :cook_time, :category, :instructions, :user_id, ingredient_attributes: [:name, :allergen_warning, :ingredient_type, :measurement, :spice_level], ingredient_ids: [])
  end

end
