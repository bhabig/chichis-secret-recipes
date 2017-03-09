class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in? && current_user
      if params[:user_id] && (params[:user_id].to_i == current_user.id || current_user.admin?)
      @user = User.find_by(params[:user_id])
      @recipes = current_user.recipes unless current_user.recipes.empty?
      else
        @recipes = Recipe.all
      end
    else
      redirect_to :back, alert: "must be signed in"
    end
  end

  def new
    if logged_in? && current_user && (current_user.id == params[:user_id].to_i || current_user.admin?)
      @recipe = current_user.recipes.build
    else
      redirect_to :back, alert: "can't perform this action. try signing in and make sure you're on your own profile"
    end
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
    if logged_in? && current_user
      render :show
    else
      redirect_to :back, alert: "must be logged in"
    end
  end

  def edit
    if logged_in? && current_user && (current_user.id == @recipe.user_id || current_user.admin?)
      render :edit
    else
      redirect_to :back, alert: "must be logged in and the recipe must belong to you"
    end
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
    if logged_in? && current_user && (current_user.id == @recipe.user_id || current_user.admin?)
      if @recipe.destroy
        redirect_to user_recipes_path(params[:user_id])
      else
        redirect_to user_recipe_path(params[:user_id], @recipe)
      end
    else
      redirect_to root_path, alert: "must be signed in and owner of this recipe"
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :cook_time, :category, :instructions, :user_id, ingredient_select: [], ingredient_attributes: [:name, :allergen_warning, :ingredient_type, :measurement, :spice_level])
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id].to_i)
  end

end
