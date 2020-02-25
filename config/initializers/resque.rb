require 'resque/server'
require 'resque/scheduler/server'
require 'active_scheduler'

Resque.redis = Redis.current

if Rails.env.development?
  logfile = File.open(File.join(Rails.root, 'log', 'resque.log'), 'a')
  logfile.sync = true
  Resque.logger = ActiveSupport::Logger.new(logfile)
  Resque.logger.level = Logger::INFO
end

yaml_schedule    = YAML.load_file(Rails.root.join('config', 'schedule.yml')) || {}
wrapped_schedule = ActiveScheduler::ResqueWrapper.wrap yaml_schedule
Resque.schedule  = wrapped_schedule
