module Rates
  class SendNotification
    include Interactor

    def call
      ActionCable.server.broadcast(RateChannel::STREAM, value: context.rate_value)
    end
  end
end
