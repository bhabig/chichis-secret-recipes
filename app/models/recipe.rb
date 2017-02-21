class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates_presence_of :name, :cook_time, :instructions

  #method to make cook_time readable
end
