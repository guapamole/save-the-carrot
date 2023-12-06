require "open-uri"
require "nokogiri"

class RecipesController < ApplicationController
  def generate_recipes
    @ingredients = params.dig(:choices, :ingredients).reject(&:empty?).map(&:to_i).map { |id| Ingredient.find(id).name }
    @quantity = params.dig(:choices, :quantity)
    @meal_type = params.dig(:choices, :meal_type)
    GenerateRecipesJob.perform_later(current_user, @ingredients, @quantity, @meal_type, { img: true })
    redirect_to recipes_path
  end

  def index

  end

  def create
    @recipe = Recipe.new
    @recipe.name = params[:name]
    @recipe.difficulty = params[:difficulty]
    @recipe.preptime = params[:preptime]
    @recipe.meal_type = params[:meal_type]
    @recipe.content = params[:content]
    @recipe.ingredients = params[:ingredients]
    file = params[:img]
    @recipe.image_url = @recipe.photo.attach(io: URI.open(file), filename:"image.jpg", content_type: "image/jpg")
    @recipe.cookbook = current_user.cookbooks.first

    if @recipe.save
      redirect_to cookbook_path(current_user.cookbooks.first)
    end

  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to cookbook_path(current_user)
  end


end
