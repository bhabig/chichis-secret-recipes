class ChangeMealIdToRecipeId < ActiveRecord::Migration[5.0]
  def change
    rename_column :recipe_ingredients, :meal_id, :recipe_id
  end
end
