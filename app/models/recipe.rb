class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  validates_presence_of :name, :cook_time, :instructions, :category

  attr_reader :ingredients_attributes

  def ingredient_attributes=(t)
    t.delete_if{|n,h| h[:name].empty?}
    t.each do |num, hash|
      ingredient = Ingredient.find_or_create_by(hash.except("measurement"))
      binding.pry
      self.save
      self.ingredients << ingredient unless self.ingredients.include?(ingredient)
      RecipeIngredient.all.last.update(measurement: hash[:measurement])
    end
  end

  def ingredient_select(hash)
    hash.each do |name, info_hash|
      if info_hash['id'].to_i == 1 && info_hash['measurement'] != ""
        @ingredient = Ingredient.find_by(name: name)
        self.ingredients << @ingredient unless !@ingredient || self.ingredients.include?(@ingredient)
        binding.pry
      end
    end
  end

  #method to make cook_time readable
end
