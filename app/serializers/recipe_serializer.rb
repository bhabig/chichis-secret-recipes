class RecipeSerializer < ActiveModel::Serializer
  attributes :name, :id, :user_id, :recipe_avatar, :cook_time, :instructions, :category
  belongs_to :user
  has_many :ingredients
  has_many :recipe_ingredients
end
