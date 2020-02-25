class RateChangeLog < ApplicationRecord
  validates :value, presence: true, numericality: { greater_than: 0 }

  EXTERNAL_RATE_REDIS_KEY = 'external_currency_rate'.freeze
  CUSTOM_RATE_KEY = 'is_custom_rate'.freeze

  def self.last_rate
    order(created_at: :desc).limit(1).pluck(:value).first
  end
end
