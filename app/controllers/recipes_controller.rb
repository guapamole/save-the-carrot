require "open-uri"
require "nokogiri"

class RecipesController < ApplicationController
  def index
    ingredients_list = current_user.ingredients.map(&:name).join(", ")

    @recipes = GenerateRecipes.new(current_user).generate(with_images: true)
    @recipe = Recipe.new
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
