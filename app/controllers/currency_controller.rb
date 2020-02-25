class CurrencyController < ApplicationController
  def index
    @presenter = RatePresenter.new
  end
end
