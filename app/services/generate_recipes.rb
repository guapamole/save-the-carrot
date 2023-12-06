class GenerateRecipes
  def initialize(user, ingredients, quantity, meal_type)
    @user = user
    @ingredients = ingredients
    @quantity = quantity
    @meal_type = meal_type
    @client = OpenAI::Client.new
  end

  def generate(options = {})
    response = @client.chat(parameters: {
      model: "gpt-3.5-turbo-1106",
      response_format: { type: "json_object" },
      messages: [{ role: "user", content: message }]
    })

    content = JSON.parse(response["choices"][0]["message"]["content"])

    if options[:with_images]
      content.dig("recipes").each do |recipe|
        response = @client.images.generate(parameters: {
          prompt: "A recipe image of #{recipe["name"]}", size: "256x256"
        })

        recipe["img"] = response["data"][0]["url"]
      end
    end

    return content
  end

  private

  def list
    @ingredients
  end

  def message
    "Provide a JSON-formatted list (key: 'recipes') of simple recipes containing the ingredients #{list}.
    For each recipe, include the following details: name (JSON key),
    difficulty (on a scale of 5), prep time, cooking time, #{@meal_type}, and the number of servings #{@quantity}.
    Ensure that the list is structured with the necessary information for each recipe.
    Additionally, include any specific instructions or requirements for the preparation if needed."
  end
end
