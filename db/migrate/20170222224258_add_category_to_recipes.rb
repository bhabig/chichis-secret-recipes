class AddCategoryToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :category, :integer
  end
end
