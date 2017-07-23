class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index #full recipe collection set in authorization yield
    logged_in_yield do
      authorization_for_recipe_and_ingredient_yield do
        @user = User.find_by(id: params[:user_id])
        @recipes = current_user.recipes unless current_user.recipes.empty?
        respond_to do |format|
          format.html { render :index }
          format.json { render json: @recipes }
        end
      end
    end
  end

  def new
    authorization_for_recipe_and_ingredient_yield do
      @recipe = current_user.recipes.build
    end
  end

  def create #can and must be refactored but wait until assessment - revamp bc of cocoon or other strategy?
    recipe_create_update_yield do
      @recipe = Recipe.new(recipe_params)
      message = @recipe.ingredient_select(params[:recipe][:ingredient_select]) unless !(params[:recipe][:ingredient_select])
      if message == "sorry, all ingredients need measurements" || message == "you must select an ingredient to give it a measurement"
        redirect_to new_user_recipe_path(current_user), alert: message
      elsif !@recipe.save
        render :new
      elsif @recipe.save
        redirect_to user_recipe_path(@recipe.user_id, @recipe)
      end
    end
  end

  def recipe_ingredient_new
    @ingredient = Ingredient.new
    render :recipe_ingredient_new, layout: false
  end

  def show #yield?
    logged_in_yield do
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @recipe }
      end
    end
  end

  def edit #yield?
    recipe_new_edit_yied do
      render :edit
    end
  end

  def update  #can and must be refactored but wait until assessment - revamp bc of cocoon or other strategy?
    recipe_create_update_yield do
      @recipe.update(recipe_params)
      message = @recipe.ingredient_select(params[:recipe][:ingredient_select])
      if message.class == String
        redirect_to edit_user_recipe_path(@recipe), alert: "#{message}"
      elsif @recipe.save
        redirect_to user_recipe_path(@recipe.user_id, @recipe)
      else
        render :edit
      end
    end
  end

  def destroy #clunky, but no refactor options are jumping out at me. is a yield pointless?
    destroy_authorization_yield do
      if @recipe.destroy
        redirect_to user_recipes_path(params[:user_id])
      else
        redirect_to user_recipe_path(params[:user_id], @recipe)
      end
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :recipe_avatar, :cook_time, :category, :instructions, :user_id, ingredient_select: [], ingredient_ids: [], ingredient_attributes: [:name, :allergen_warning, :ingredient_type, :measurement, :spice_level])
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id].to_i)
  end

  def recipe_new_edit_yied
    if logged_in? && current_user && (current_user.id == @recipe.user_id || current_user.admin?)
      yield
    elsif current_user.id != @recipe.user_id && !current_user.admin?
      redirect_to "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    else
      redirect_to :back, alert: "must be logged in and make sure this belongs to you"
    end
  end

  def recipe_create_update_yield
    name_errors = Ingredient.validation_checks(params)
    if name_errors && !name_errors.empty?
      redirect_to new_user_recipe_path(current_user), alert: "#{name_errors.length} ingredients already exist, but have different attributes. please review carefully."
    elsif RecipeIngredient.measurement_sanitizing(params[:recipe][:ingredient_attributes]) == true
      redirect_to new_user_recipe_path(current_user), alert: "sorry, all ingredients must have a measurement"
    else
      other_errors = Ingredient.attribute_checks(params)
      if !other_errors || other_errors.empty?
        yield
      else
        redirect_to new_user_recipe_path(current_user), alert: "#{other_errors.length} ingredient forms had 1 or more empty fields."
      end
    end
  end

  def destroy_authorization_yield
    if logged_in? && current_user && (current_user.id == @recipe.user_id || current_user.admin?)
      yield
    elsif current_user.id != @recipe.user_id && !current_user.admin?
      redirect_to "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    else
      redirect_to root_path, alert: "must be signed in and owner of this recipe"
    end
  end

end
