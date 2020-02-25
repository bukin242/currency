module Concerns
  module Validation
    extend ActiveSupport::Concern

    included do
      def rate_value_validate!
        value = context.rate_value
        raise ArgumentError, I18n.t('errors.messages.rate_value.blank') if value.blank?

        value.sub!(',', '.') if value.is_a?(String)
        value = Float(value)

        raise ArgumentError, I18n.t('errors.messages.rate_value.zero') if value <= 0

        context.rate_value = value
      rescue ArgumentError => e
        context.fail!(error: e.message)
      end

      def expire_time_validate!
        raise ArgumentError, I18n.t('errors.messages.expire_time.blank') if context.expire_time.blank?

        context.expire_seconds = Time.parse(context.expire_time).minus_with_coercion(Time.now).to_i
        raise ArgumentError, I18n.t('errors.messages.expire_time.less_now') if context.expire_seconds <= 0
      rescue ArgumentError => e
        context.fail!(error: e.message)
      end
    end
  end
end
