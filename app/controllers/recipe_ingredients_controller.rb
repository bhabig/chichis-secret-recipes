class RecipeIngredientsController < ApplicationController
  def index
    if logged_in? && current_user
      @ingredient = Ingredient.find_by(id: params['ingredient_id'].to_i)
      recipe_ids = RecipeIngredient.all.map{|ri| ri.recipe_id if ri.ingredient_id == params['ingredient_id'].to_i}
      @recipes = recipe_ids.compact.map{|id| Recipe.find_by(id: id)}
    else
      redirect_to root_path, alert: "login first"
    end
  end
end
