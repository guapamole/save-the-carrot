class ImageDetection
  def initialize(user, url)
    @user = user
    @url = url
    @client = OpenAI::Client.new
  end

  def generate(options = {})
    response = @client.chat(
    parameters: {
      model: "gpt-4-vision-preview",
      messages: [{ role: "user", content: payload}],
      max_tokens: 500,
    }
  )
  end

  private

  def payload
    messages = [
      { "type": "text", "text": prompt },
      { "type": "image_url",
        "image_url": {
          "url": @url
        },
      }
    ]
  end

  def prompt
    "Give me a list of food ingrdients that are in this image - I want a list of ingredients with there types (ex: milk, tomato, eggs, etc...).
    I want the list to be in a format that I can use in my code.
    I expect this format of data : [
      {'type': 'fruit', 'name': 'lime'},
      {'type': 'vegetable', 'name': 'cucumber'},
      {'type': 'beverage', 'name': 'carrot juice'},
    ]"
  end

  def result
    data = response.dig("choices", 0, "message", "content")
      .scan(/\{'type': '.+', 'name': '.+'}/)
      .map { |item| JSON.parse(item.gsub("'", '"')) }
    p data
  end
end
