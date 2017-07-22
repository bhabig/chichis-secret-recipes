class UserRecipesSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :recipe_avatar
end
