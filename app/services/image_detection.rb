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
      messages: payload,
      max_tokens: 700
    })
    debugger
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
    "give me a list of aliments in this image."
  end
end
