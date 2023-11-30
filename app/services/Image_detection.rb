class ImageDetections
  include HTTParty
  base_uri 'https://chooch-api.com'

  def self.recognize_image(photo)
    response = post('/recognize', body: { photo: photo })
    JSON.parse(response.body)
  end
end
