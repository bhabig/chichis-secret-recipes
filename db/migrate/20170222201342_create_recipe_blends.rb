class CreateRecipeBlends < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_blends do |t|
      t.integer :recipe_id
      t.integer :blend_id

      t.timestamps
    end
  end
end
