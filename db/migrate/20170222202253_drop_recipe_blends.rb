class DropRecipeBlends < ActiveRecord::Migration[5.0]
  def change
    drop_table :recipe_blends
  end
end
