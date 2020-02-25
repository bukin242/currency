require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Currency
  class Application < Rails::Application
    config.load_defaults 5.2
    config.active_job.queue_adapter = :resque

    config.generators do |g|
      g.test_framework :rspec
    end

    config.time_zone = 'Moscow'
    config.active_record.default_timezone = :local
  end
end
