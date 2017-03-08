class RecipeIngredientsController < ApplicationController
  def index
    if logged_in? && current_user
      @ingredient = Ingredient.find_by(id: params['ingredient_id'].to_i)
      @recipes = RecipeIngredient.recipes_for_ingredient(@ingredient.id)
    else
      redirect_to root_path, alert: "login first"
    end
  end
end
