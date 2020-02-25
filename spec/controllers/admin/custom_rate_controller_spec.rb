require 'rails_helper'

describe Admin::CustomRateController, type: :controller do
  context "#new" do
    before { get :new }

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns[:presenter]).to be_a RatePresenter }
  end

  context "#create" do
    let(:params) { {custom_rate: {rate_value: rate_value, expire_time: expire_time}} }
    before { post :create, params: params }

    context 'when success' do
      let(:rate_value) { 50 }
      let(:expire_time) { 1.day.from_now }

      it { expect(RateChangeLog.last_rate).to eq 50 }
      it { expect(response).to redirect_to(root_url) }
    end

    context 'when fail' do
      let(:rate_value) { -1 }
      let(:expire_time) { 1.day.ago }

      it { expect(response).to redirect_to(action: :new) }
    end
  end
end
