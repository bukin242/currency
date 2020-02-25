require 'rails_helper'

describe Rates::CustomUpdate do
  context '.call' do
    before do
      allow(ActionCable.server).to receive(:broadcast)
      described_class.call(rate_value: '50', expire_time: 1.day.from_now.to_s)
    end

    it { expect(RateChangeLog.last_rate).to eq 50 }
    it { expect(ActionCable.server).to have_received(:broadcast).with(RateChannel::STREAM, value: 50) }
  end
end
