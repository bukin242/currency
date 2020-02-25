module Admin
  class CustomRateController < ApplicationController
    def new
      @presenter = RatePresenter.new
    end

    def create
      result = Rates::CustomUpdate.call(
        rate_value: custom_rate_params[:rate_value],
        expire_time: custom_rate_params[:expire_time]
      )

      if result.success?
        flash[:notice] = I18n.t('course_has_been_set', expire_time: result.expire_time)
        redirect_to :root
      else
        flash[:alert] = result.error
        redirect_to action: :new
      end
    end

    private

    def custom_rate_params
      params.require(:custom_rate).permit([:rate_value, :expire_time])
    end
  end
end
