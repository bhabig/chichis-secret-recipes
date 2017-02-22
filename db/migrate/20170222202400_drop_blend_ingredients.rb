class DropBlendIngredients < ActiveRecord::Migration[5.0]
  def change
    drop_table :blend_ingredients
  end
end
