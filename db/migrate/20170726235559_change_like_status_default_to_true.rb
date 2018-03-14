class ChangeLikeStatusDefaultToTrue < ActiveRecord::Migration[5.0]
  def change
    change_column :likes, :status, :boolean, default: true
  end
end
