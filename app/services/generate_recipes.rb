class GenerateRecipes
  def initialize(user)
    @user = user
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
    @user.ingredients.map(&:name).join(", ")
  end

  def message
    "Donne moi une liste en format json (clé recipes) de recettes simples avec les ingredients #{list}. Avant la liste, peux-tu indiquer le nom de chaque recettes (json clé name), la difficulté (sur 5), preptime, cooking_time, meal-type(entrée, plats, desserts), et le nombre de personne."
  end
end
