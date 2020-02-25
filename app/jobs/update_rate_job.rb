class UpdateRateJob < ApplicationJob
  queue_as :update_rate

  def perform
    Rates::Update.call
  end
end
