class RecipeIngredientsController < ApplicationController
  def index
    logged_in_yield do
      @ingredient = Ingredient.find_by(id: params['ingredient_id'].to_i)
      @recipes = RecipeIngredient.recipes_for_ingredient(@ingredient.id)
    end
  end
end
