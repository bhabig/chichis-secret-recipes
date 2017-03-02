class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:edit, :update, :destroy]
  
  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to ingredient_path(@ingredient)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to ingredient_path(@ingredient)
    else
      render :edit
    end
  end

  def destroy
    if @ingredient
      @ingredient.destroy
      redirect_to :back
    else
      redirect_to :back, alert: "ingredient couldn't be found"
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :allergen_warning, :spice_level, :ingredient_type)
  end

  def set_ingredient
    @ingredient ||= Ingredient.find_by(params[:id])
  end

end
