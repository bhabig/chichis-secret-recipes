class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  
  validates_presence_of :name, :allergen_warning, :spice_level, :type
  validates_uniqueness_of :name

  #need method for allergen_warning

  #need method for spice_level

  #need method for type
end
