class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.boolean :allergen_warning
      t.integer :spice_level
      t.integer :type

      t.timestamps
    end
  end
end
