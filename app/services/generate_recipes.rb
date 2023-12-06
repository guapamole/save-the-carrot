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
    "Give me a list of 2 simple recipes for a #{meal_type} including these ingredients #{list}, for #{@quantity} persons.
    I expect a response that match this json format:
      {
        recipes: [
          {
            name: 'eggs omelette',
            difficulty: '2',
            preptime: '45',
            cooking_time: '30',
            meal_type: 'meal',
            ingredients: ['eggs', 'pepper', 'butter'],
            content: 'Season the beaten eggs well with salt and pepper. Heat the oil and butter in a non-stick frying pan over a medium-low heat until the butter has melted and is foaming.'
          }
        ]
      }
    The difficulty must be a number from 1 to 5 and content must be the instructions. The answer must be in french. ingredients must be an array. ingredients must be in french.
    "
  end

  def meal_type
    case @meal_type.downcase
    when 'entrée' then 'starter'
    when 'plat' then 'meal'
    when 'dessert' then 'dessert'
    end
  end
end
