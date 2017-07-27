class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  #method to convert category integer into category type to display

  def self.measurement_sanitizing(new_ingredient_input)
    if new_ingredient_input && new_ingredient_input.length == 1
      (moment_of_truth = true) if new_ingredient_input[0]['measurement'] == ""
    elsif new_ingredient_input && new_ingredient_input.length > 1
      new_ingredient_input.each do |i|
        (moment_of_truth = true) if !i['measurement']
        break
      end
    end
    moment_of_truth
  end

  def self.recipes_for_ingredient(ing_id)
    recipe_ids = self.all.map{|ri| ri.recipe_id if ri.ingredient_id == ing_id}
    @recipes = recipe_ids.compact.map{|id| Recipe.find_by(id: id)}
  end
end
