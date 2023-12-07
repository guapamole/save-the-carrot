class ImageDetectionJob < ApplicationJob
  queue_as :default

  def perform(user, url)
    ingredients = ImageDetection.new(user, url).generate
    renderer = ApplicationController.renderer.new
    html = renderer.render(partial: "ingredients/results", locals: { ingredients: ingredients })

    ResultsChannel.broadcast_to("results", html)
  end
end
