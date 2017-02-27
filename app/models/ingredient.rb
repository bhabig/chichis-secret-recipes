class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates_presence_of :name, :spice_level, :ingredient_type
  validates_uniqueness_of :name

  def self.validation_checks(params) #refactor by creating 2 helper methods for logic here
    hash = params["recipe"]["ingredient_attributes"]
    hash.delete_if{|n,h| h[:name].empty?}
    @y = hash.map do |n, h|
      i = Ingredient.find_by(name: h["name"])
      if i
        h.except("measurement").map do |k, v|
          v if v == i.instance_eval(k).to_s
        end
      end
    end
    errors_array = []
    @y.compact.each do |array|
      if array.include?(nil)
        errors_array << "recipe could not be created because an ingredient with the name '#{array[0]}' already exists with different attributes. either select that ingredient from the existing menu or change the name of this ingredient"
      end
    end
    errors_array
  end

  def self.attribute_checks(params)
    bad_ingredients = []
    @y = params[:recipe][:ingredient_attributes].map do |num, hash|
      hash.except("measurement").map{|key, val| key if val.empty?}
    end
    @y.each{|array| bad_ingredients << array unless array.compact.empty?}
    bad_ingredients
  end

  #need method for allergen_warning

  #need method for spice_level

  #need method for type
end
