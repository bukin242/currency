config_redis = Rails.application.config_for(:redis).symbolize_keys
Rails.application.config.redis = config_redis
Redis.current = Redis.new(config_redis)
$redis = Redis.current
