module Concerns
  module Redis
    private

    def redis
      @redis ||= ::Redis.current
    end

    def custom_rate
      return @custom_rate if defined? @custom_rate

      @custom_rate = redis.get(RateChangeLog::CUSTOM_RATE_KEY)
      @custom_rate = @custom_rate.to_f if @custom_rate
    end

    def external_rate
      return @external_rate if defined? @external_rate

      @external_rate = redis.get(RateChangeLog::EXTERNAL_RATE_REDIS_KEY)
      @external_rate = @external_rate.to_f if @external_rate
    end
  end
end
