class AddCategoryToRecipeIngredients < ActiveRecord::Migration[5.0]
  def change
    add_column :recipe_ingredents, :category, :integer
  end
end
