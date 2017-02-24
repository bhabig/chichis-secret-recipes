class AddDefaultToAllergenWarning < ActiveRecord::Migration[5.0]
  def change
    change_column :ingredients, :allergen_warning, :boolean, default: false
  end
end
