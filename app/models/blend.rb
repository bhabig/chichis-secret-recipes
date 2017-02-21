class Blend < ApplicationRecord
  has_many :blend_ingredients
  has_many :ingredients, through: :blend_ingredients

  validates_presence_of :name, :type, :spice_level

  #need method for type

  #need method for spice_level (same as ingredient)
end
