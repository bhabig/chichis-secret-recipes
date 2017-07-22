class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :recipe_avatar, :cook_time, :instructions, :category, :ingredients
  belongs_to :user
end
