class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :blend_ingredients
  has_many :blends, through: :blend_ingredients
end
