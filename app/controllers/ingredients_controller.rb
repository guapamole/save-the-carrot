class IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all
    @recipe = Recipe.new
  end

  def show
    @ingredient = Ingredient.find_by(id: params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to ingredients_path, notice: "Ingrédient ajouté avec succès."
    else
      render :new, alert: "Problème lors de l'ajout de l'ingrédient."
    end
  end

  def edit
    @ingredient = Ingredient.find_by(id: params[:id])
  end

  def update
    ingredient = Ingredient.find_by(id: params[:id])
    ingredient.update(ingredient_params)
    redirect_to ingredient_path(ingredient)
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity, :purchase_date)
  end

end
