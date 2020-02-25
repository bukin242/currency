require 'open-uri'

module Rates
  class Parse
    include Interactor
    include Concerns::Redis
    include Concerns::Validation

    EXTERNAL_API_URL = 'http://www.cbr.ru/scripts/XML_daily.asp'.freeze
    FIND_PATCH = "//ValCurs/Valute/CharCode[contains(text(),'USD')]/parent::Valute/Value".freeze

    def call
      context.fail!(message: :skip) if custom_rate.present?
      context.rate_value = document.xpath(FIND_PATCH).text || ''

      rate_value_validate!

      context.fail!(message: :skip) if rate_is_same?
      redis.set(RateChangeLog::EXTERNAL_RATE_REDIS_KEY, context.rate_value)
    end

    private

    def rate_is_same?
      external_rate.present? && external_rate == context.rate_value
    end

    def document
      @document ||= Nokogiri::XML(open(EXTERNAL_API_URL))
    rescue StandardError => e
      context.fail!(error: e.message)
    end
  end
end
