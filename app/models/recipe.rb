class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :likes
  has_many :likers, through: :likes,
                    class_name: "Like",
                    foreign_key: "user_id",
                    source: :user #specifying source key to this alias working

  has_attached_file :recipe_avatar, default_url: ':style/recipe_default.png'
  validates_attachment_content_type :recipe_avatar, content_type: /\Aimage\/.*\z/
  validates_presence_of :name, :cook_time, :instructions, :category

  attr_reader :ingredients_attributes

  @@categories = ["Breakfast", "Lunch", "Dinner", "Snack"]

  def self.categories
    @@categories
  end

  def ingredient_attributes=(t) #sets newly created ingredients on new recipe
    t.delete_if{|h| h[:name].empty?}
    t.each do |hash|
      ingredient = Ingredient.find_or_create_by(hash.except("measurement"))
      self.recipe_ingredients.build(ingredient: ingredient, measurement: hash['measurement']) unless self.ingredients.include?(ingredient)
    end
  end

  def ingredient_select(hash) #sets pre-existing ingredients on new recipe
    hash.each do |name, info_hash|
      @ingredient = Ingredient.find_by(name: name)
      if info_hash['id'].to_i == 1 && info_hash['measurement'] != ""
        self.recipe_ingredients.build(ingredient: @ingredient, measurement: info_hash['measurement']) unless !@ingredient || self.ingredients.include?(@ingredient)
      elsif info_hash['id'].to_i == 1 && info_hash['measurement'] == ""
        return "sorry, all ingredients need measurements"
      elsif info_hash['id'].to_i == 0 && info_hash['measurement'] != ""
        return "you must select an ingredient to give it a measurement"
      else
        self.remove_on_update(@ingredient) unless !self.ingredients.include?(@ingredient)
      end
    end
  end

  def remove_on_update(ingredient)
    self.ingredients.delete(ingredient)
  end

  def recipe_cook_time
    hours = self.cook_time / 60
    minutes = self.cook_time % 60
    return "#{hours} hours and #{minutes} minutes"
  end
end
