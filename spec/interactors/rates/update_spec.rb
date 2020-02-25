require 'rails_helper'

describe Rates::Update do
  context '.call' do
    let!(:data) { file_fixture('cbr_rate_daily.xml').read }

    before do
      allow(ActionCable.server).to receive(:broadcast)
      stub_request(:get, 'http://www.cbr.ru/scripts/XML_daily.asp').to_return(status: 200, body: data)
      described_class.call
    end

    it { expect(RateChangeLog.last_rate).to eq 50 }
    it { expect(ActionCable.server).to have_received(:broadcast).with(RateChannel::STREAM, value: 50) }
  end
end
