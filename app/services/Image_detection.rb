class ImageDetections
  def initialize(user, ingredients)
    @user = user
    @ingredients = ingredients
    @client = OpenAI::Client.new
  end

  def generate(options = {})
    response = @client.chat(parameters: {
      model: "gpt-4-1106-preview",
      response_format: { type: "json_object" },
      messages: [{ role: "user", content: message }]
    })

    @ingredients.each do |ingredient|
      if ingredient.photo.attached?
        photo_url = Rails.application.routes.url_helpers.rails_blob_path(ingredient.photo, only_path: true)
        response = @client.images.generate(parameters: {
          prompt: "A List of ingredient present in the #{photo_url}"
        })

        ingredient.img_url = response["data"][0]["url"]
      end
    end

    return content
  end

  private

  def list
    @ingredients
  end

  def message
    "Donne moi la liste des ingrédients #{list.join(", ")}"
  end
end
