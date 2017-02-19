class CreateRecipeIngredents < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_ingredents do |t|
      t.integer :meal_id
      t.integer :ingredient_id
      t.string :measurement

      t.timestamps
    end
  end
end
