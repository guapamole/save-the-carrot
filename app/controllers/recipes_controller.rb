require "open-uri"
require "nokogiri"

class RecipesController < ApplicationController
  def index
    ingredients = params.dig(:choices, :ingredients).reject(&:empty?).map(&:to_i).map { |id| Ingredient.find(id).name }
    quantity = params.dig(:choices, :quantity)
    meal_type = params.dig(:choices, :meal_type)
    @recipes = GenerateRecipes.new(current_user, @ingredients, @quantity, @meal_type).generate(with_images: true)
  end

  def create
    @recipe = Recipe.new
    @recipe.name = params[:name]
    @recipe.difficulty = params[:difficulty]
    @recipe.preptime = params[:preptime]
    @recipe.cookbook = current_user.cookbooks.first
    if @recipe.save
      redirect_to cookbook_path(current_user.cookbooks.first)
    end
  end
end
