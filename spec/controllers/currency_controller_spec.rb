require 'rails_helper'

describe CurrencyController, type: :controller do
  context "#index" do
    before { get :index }

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns[:presenter]).to be_a RatePresenter }
  end
end
