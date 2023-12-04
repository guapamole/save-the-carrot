class ImageDetectionJob < ApplicationJob
  queue_as :default

  def perform(user, url)
    ImageDetection.new(user, url).generate
  end
end
