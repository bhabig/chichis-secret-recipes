class CreateBlendIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :blend_ingredients do |t|
      t.integer :blend_id
      t.integer :ingredient_id
      t.string :measurement

      t.timestamps
    end
  end
end
