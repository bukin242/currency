module Rates
  class SetCustom
    include Interactor
    include Concerns::Redis
    include Concerns::Validation

    def call
      rate_value_validate!
      expire_time_validate!

      redis.set(RateChangeLog::CUSTOM_RATE_KEY, context.rate_value)
      redis.expire(RateChangeLog::CUSTOM_RATE_KEY, context.expire_seconds)

      redis.del(RateChangeLog::EXTERNAL_RATE_REDIS_KEY)
    end
  end
end
