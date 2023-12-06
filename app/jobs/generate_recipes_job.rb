class GenerateRecipesJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(user, ingredients, quantity, meal_type, options = {})
    recipes = GenerateRecipes.new(user, ingredients, quantity, meal_type).generate(with_images: options[:img])
    renderer = ApplicationController.renderer.new
    html = renderer.render(partial: "recipes/content", locals: { recipes: recipes })
    # debugger
    # html = ApplicationController.new.render_to_string(partial: "recipes/content", locals: { recipes: recipes })
    RecipesChannel.broadcast_to('recipes', html)
  end
end
