class RecipesChannel < ApplicationCable::Channel
  def subscribed
    stream_for "recipes"
  end
end
