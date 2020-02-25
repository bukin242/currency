module Rates
  class AddToLog
    include Interactor
    include Concerns::Redis

    def call
      RateChangeLog.create!(value: context.rate_value)
    rescue ActiveRecord::ActiveRecordError => e
      context.fail!(error: e.message)
    end
  end
end
