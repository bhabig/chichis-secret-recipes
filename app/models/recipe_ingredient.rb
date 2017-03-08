class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  #method to convert category integer into category type to display

  def self.recipes_for_ingredient(ing_id)
    recipe_ids = self.all.map{|ri| ri.recipe_id if ri.ingredient_id == ing_id}
    @recipes = recipe_ids.compact.map{|id| Recipe.find_by(id: id)}
  end

end
