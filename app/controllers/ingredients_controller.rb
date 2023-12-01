require "open-uri"
require "nokogiri"

class IngredientsController < ApplicationController
  before_action :find_ingredient, only: [:show, :edit, :update]

  def index
    @ingredients = Ingredient.all
    @recipe = Recipe.new
  end

  def show
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = current_user.ingredients.build(ingredient_params)
    if @ingredient.save
      redirect_to_ingredient(@ingredient, "Ingrédient ajouté avec succès.")
    else
      render :new, alert: "Problème lors de l'ajout de l'ingrédient."
    end
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to_ingredient(@ingredient, "Ingrédient mis à jour avec succès.")
    else
      render :edit, alert: "Problème lors de la mise à jour de l'ingrédient."
    end
  end

  def add_an_image
    ingredients_param = params.dig(:choices, :ingredients)

    if ingredients_param.present?
        ingredient_names = ingredients_param.map { |id| Ingredient.find(id)&.name }
        @ingredient = ImageDetections.new(current_user, ingredient_names.compact).generate(with_images: true)
    end
  end

  def create_with_image
    @ingredient = current_user.ingredients.build(ingredient_params)
    if @ingredient.save
      if params[:ingredient][:photo].present?
        @ingredient.photo.attach(params[:ingredient][:photo])
      end

      @recipes = ImageDetections.new(current_user, [@ingredient]).generate(with_images: true)

      redirect_to_ingredient(@ingredient, "Ingrédient ajouté avec succès.")
    else
      render :new, alert: "Problème lors de l'ajout de l'ingrédient."
    end
  end


  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity, :purchase_date)
  end

  def find_ingredient
    @ingredient = Ingredient.find_by(id: params[:id])
  end

  def redirect_to_ingredient(ingredient, notice_message)
    redirect_to ingredient_path(ingredient), notice: notice_message
  end
end
