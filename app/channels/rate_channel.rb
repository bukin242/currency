class RateChannel < ApplicationCable::Channel
  STREAM = 'rate'.freeze

  def subscribed
    stream_from STREAM
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
