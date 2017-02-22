class DropBlends < ActiveRecord::Migration[5.0]
  def change
    drop_table :blends
  end
end
