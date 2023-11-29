require "open-uri"
require "nokogiri"

class RecipesController < ApplicationController
  def index
    ingredients_list = current_user.ingredients.map(&:name).join(", ")

    @recipes = GenerateRecipes.new(current_user).generate(with_images: true)
    # @cookbook = Cookbook.new
    # debugger
    # recipe_name = results_recipe.first["name"]
    # recipe_minute = result_recipe["name"]
    # recipe_name = result_recipe["name"]
    # recipe_name = result_recipe["name"]

    # client = OpenAI::Client.new
    # response = client.images.generate(parameters: {
    #   prompt: "A recipe image of #{recipe_name}", size: "256x256"
    # })

    # id = response["data"][0]["id"]
    # url = response["data"][0]["url"]
    # file = URI.open(url)

    # @recipe = Recipe.create(name: recipe_name, cookbook: Cookbook.find_by(user: current_user))

    # # @recipe.photo.purge if @recipe.photo.attached?
    # @recipe.photo.attach(io: file, filename: "#{id}.jpg", content_type: "image/png")

    # @recipe.save
  end
  def new

  end
end
