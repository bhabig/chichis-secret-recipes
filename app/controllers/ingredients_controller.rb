class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:edit, :update, :destroy, :show]

  def index
    logged_in_yield do
      if Ingredient.all.empty?
        redirect_to :back, alert: "sorry, no ingredients to see yet"
      else
        @ingredients = Ingredient.all
      end
    end
  end

  def new #admin only #yield?
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to ingredient_path(@ingredient)
    else
      render :new
    end
  end

  def show
    logged_in_yield do
      render :show
    end
  end

  def edit #yield?
    permission_yield do
      render :edit
    end
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to ingredient_path(@ingredient)
    else
      render :edit
    end
  end

  def destroy #yield?
    binding.pry
    if @ingredient && current_user_and_admin
      @ingredient.destroy
      redirect_to :back
    else
      redirect_to :back, alert: "ingredient couldn't be found or it doesn't belong to you"
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :allergen_warning, :spice_level, :ingredient_type)
  end

  def set_ingredient
    @ingredient = Ingredient.find_by(id: params[:id])
  end

  def logged_and_current
    logged_in? && current_user
  end

  def current_user_and_admin
    logged_and_current && current_user.admin?
  end

  def permission_yield
    if logged_and_current && current_user_and_admin || current_user_and_admin || logged_and_current
      yield
    else
      redirect_to :back, alert: "not authorized to perform this action" #can encapsulate this alert message in a method
    end
  end

  #do you need strong params if ingredients are created in the Recipe model from the recipe controller?
end
