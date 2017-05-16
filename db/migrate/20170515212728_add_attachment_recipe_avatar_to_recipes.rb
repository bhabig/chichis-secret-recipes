class AddAttachmentRecipeAvatarToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.attachment :recipe_avatar
    end
  end

  def self.down
    remove_attachment :recipes, :recipe_avatar
  end
end
