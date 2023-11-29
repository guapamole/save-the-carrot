require "open-uri"
require "nokogiri"

class RecipesController < ApplicationController
  def index
    # ingredients_list = current_user.ingredients.map(&:name).join(", ")
    ingredients = params.dig(:choices, :ingredients).reject(&:empty?).map(&:to_i).map { |id| Ingredient.find(id).name }
    quantity = params.dig(:choices, :quantity)
    meal_type = params.dig(:choices, :meal_type)
    @recipes = GenerateRecipes.new(current_user, @ingredients, @quantity, @meal_type).generate(with_images: true)
  end

  def create

  end
end
