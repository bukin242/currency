class RatePresenter
  include Concerns::Redis

  def current_rate
    @current_rate ||= custom_rate
    @current_rate ||= external_rate
    @current_rate ||= RateChangeLog.last_rate

    UpdateRateJob.perform_later unless @custom_rate

    @current_rate
  end
end
