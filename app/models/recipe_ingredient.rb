class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  #method to convert category integer into category type to display
end
