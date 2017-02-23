class RenameRecipeIngredentsToRecipeIngredients < ActiveRecord::Migration[5.0]
  def change
    rename_table :recipe_ingredents, :recipe_ingredients
  end
end
