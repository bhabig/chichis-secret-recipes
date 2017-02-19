class BlendIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :blend
end
