require 'resque/tasks'
require 'resque/scheduler/tasks'

namespace :resque do
  task setup: :environment do
    require 'resque'
    ENV['QUEUE'] = '*'
  end
end
