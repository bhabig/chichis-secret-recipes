class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user_id]
      @user = User.find_by(params[:user_id])
      @recipes = current_user.recipes unless current_user.recipes.empty?
    else
      @recipes = Recipe.all
    end
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    name_errors = Ingredient.validation_checks(params)
    if !name_errors.empty?
      redirect_to new_user_recipe_path(current_user), alert: "#{name_errors.length} ingredients already exist, but have different attributes. please review carefully."
    else
      other_errors = Ingredient.attribute_checks(params)
      if !other_errors || other_errors.empty?
        @recipe = Recipe.new(recipe_params)
        @recipe.ingredient_select(params[:recipe][:ingredient_select])
        if @recipe.save
          redirect_to user_recipe_path(@recipe.user_id, @recipe)
        else
          render :new
        end
      else
        redirect_to new_user_recipe_path(current_user), alert: "#{other_errors.length} ingredient forms had 1 or more empty fields."
      end
    end
  end

  def show
  end

  def edit
    @counter = 1
  end

  def update
    name_errors = Ingredient.validation_checks(params)
    if !name_errors.empty?
      redirect_to edit_user_recipe_path(current_user), alert: "#{name_errors.length} ingredients already exist, but have different attributes. please review carefully."
    else
      other_errors = Ingredient.attribute_checks(params)
      if !other_errors || other_errors.empty?
        @recipe.update(recipe_params)
        message = @recipe.ingredient_select(params[:recipe][:ingredient_select])
        if message.class == String
          redirect_to edit_user_recipe_path(@recipe), alert: "#{message}"
        elsif @recipe.save
          redirect_to user_recipe_path(@recipe.user_id, @recipe)
        else
          render :edit
        end
      else
        redirect_to edit_user_recipe_path(current_user), alert: "#{other_errors.length} ingredient forms had 1 or more empty fields."
      end
    end
  end

  def destroy

  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :cook_time, :category, :instructions, :user_id, ingredient_select: [], ingredient_attributes: [:name, :allergen_warning, :ingredient_type, :measurement, :spice_level])
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

end
