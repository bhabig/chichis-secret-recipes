class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  validates_presence_of :name, :cook_time, :instructions, :category

  attr_reader :ingredients_attributes

  def ingredient_attributes=(t)
    binding.pry
    t.delete_if{|n,h| h[:name].empty?}
    t.each do |num, hash|
      ingredient = Ingredient.find_or_create_by(hash.except("measurement"))
      self.save
      self.ingredients << ingredient unless self.ingredients.include?(ingredient)
      RecipeIngredient.all.last.update(measurement: hash[:measurement])
    end
  end

  def ingredient_select(params)
    binding.pry
  end

  #method to make cook_time readable
end
