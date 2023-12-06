class CookbooksController < ApplicationController

  def index
    #display all the recipes in my cookbook that I selected from the index/recipes
  end

  def show
    @cookbook = Cookbook.find(params[:id])
    @recipes = @cookbook.recipes
  end



    # @ingredient = Ingredient.find(params[:ingredient_id])
    # @recipe = Recipe.find(params[:recipe_id])
    #display a full recipe
end
