class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :user_avatar, :recipes
  has_many :recipes, serializer: UserRecipeSerializer
end
