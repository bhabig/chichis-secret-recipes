class LikeSerializer < ActiveModel::Serializer
  attributes :user_id, :recipe_id, :status
  belongs_to :recipe
  belongs_to :user
end
