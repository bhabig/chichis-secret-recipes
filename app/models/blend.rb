class Blend < ApplicationRecord
  has_many :blend_ingredients
  has_many :ingredients, through: :blend_ingredients
end
