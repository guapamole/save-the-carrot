class ResultsChannel < ApplicationCable::Channel
  def subscribed
    stream_for "results"
  end
end
