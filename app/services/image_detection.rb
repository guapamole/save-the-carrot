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

    return response.dig("choices", 0, "message", "content")
                   .scan(/\{'type': '.+', 'name': '.+'}/)
                   .map { |item| JSON.parse(item.gsub("'", '"')) }

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
    "Provide me with a list of food ingredients present in this image.
    I want a list of ingredients with their types (e.g., milk, tomato, eggs, etc.).
    I want the list to be in a format that I can use in my code, but can you give me the result in French.
    I expect this format of data : [
      {'type': 'fruit', 'name': 'lime'},
      {'type': 'vegetable', 'name': 'cucumber'},
      {'type': 'beverage', 'name': 'carrot juice'},
    ]"
  end
end
