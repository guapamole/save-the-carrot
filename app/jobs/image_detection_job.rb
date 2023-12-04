class ImageDetectionJob < ApplicationJob
  queue_as :default

  def perform(user, url)
    data = ImageDetection.new(user, url).generate
    ResultsChannel.broadcast_to("results", data)
  end
end
