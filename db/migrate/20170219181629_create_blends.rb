class CreateBlends < ActiveRecord::Migration[5.0]
  def change
    create_table :blends do |t|
      t.string :name
      t.integer :type
      t.integer :spice_level

      t.timestamps
    end
  end
end
