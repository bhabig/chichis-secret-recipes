class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates_presence_of :spice_level, :ingredient_type
  validates_uniqueness_of :name

  def self.validation_checks(params=nil) #refactor by creating 2 helper methods for logic here
    if params["recipe"]["ingredient_attributes"] && !params["recipe"]["ingredient_attributes"].empty?
      hash = params["recipe"]["ingredient_attributes"]
      hash.delete_if do |n|
        n[:name].empty?
      end
      y = self.ing_attr_collection(hash)
      errors_array = []
      self.errors_collection(y, errors_array)
    end
  end

  def self.ing_attr_collection(hash=nil)
    y = hash.map do |n,h|
      i = Ingredient.find_by(name: n["name"])
      i ? h.except("measurement").map{|k, v| v if v == i.instance_eval(k).to_s} : nil
    end
    y
  end

  def self.errors_collection(y=nil, errors_array)
    y.compact.each do |array|
      if array.include?(nil)
        errors_array << "recipe could not be created because an ingredient with the name '#{array[0]}' already exists with different attributes. either select that ingredient from the existing menu or change the name of this ingredient"
      end
    end
    binding.pry
    errors_array
  end

  def self.attribute_checks(params)
    if params["recipe"]["ingredient_attributes"] && !params["recipe"]["ingredient_attributes"].empty?
      bad_ingredients = []
      @y = params[:recipe][:ingredient_attributes].map do |hash|
        hash.except("measurement").map{|key, val| key if val.empty?}
      end
      @y.each{|array| bad_ingredients << array unless array.compact.empty?}
      bad_ingredients
    end
  end

  def ingredient_spice_level
    if self.spice_level >= 0 && self.spice_level < 4
      return "not spicy"
    elsif self.spice_level >= 4 && self.spice_level < 8
      return "moderately spicy"
    elsif self.spice_level >= 8 && self.spice_level <= 10
      return "very spicy"
    end
  end

  def ingredient_type_sorter
    case self.ingredient_type
    when 1
      return "food"
    when 2
      return "spice"
    when 3
      return "sauce"
    when 4
      return "other"
    end
  end
end
