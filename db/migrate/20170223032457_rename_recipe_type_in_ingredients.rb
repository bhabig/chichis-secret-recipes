class RenameRecipeTypeInIngredients < ActiveRecord::Migration[5.0]
  def change
    rename_column :ingredients, :recipe_type, :ingredient_type
  end
end
