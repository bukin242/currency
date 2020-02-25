require 'rails_helper'

describe Rates::Parse do
  context '.call' do
    subject { described_class.call }

    context 'when correct data' do
      let!(:data) { file_fixture('cbr_rate_daily.xml').read }

      before do
        stub_request(:get, 'http://www.cbr.ru/scripts/XML_daily.asp').to_return(status: 200, body: data)
      end

      context 'when value not chaged' do
        it do
          expect(subject).to be_success
          expect(subject.rate_value).to eq 50
          expect(described_class.call.message).to eq :skip
        end
      end

      context 'when custom rate has been set' do
        before { allow_any_instance_of(described_class).to receive(:custom_rate).and_return(10) }
        it { expect(subject.message).to eq :skip }
      end
    end

    context 'when no correct data' do
      before do
        stub_request(:get, 'http://www.cbr.ru/scripts/XML_daily.asp').to_return(status: 200, body: 'no data')
      end

      it { expect(subject).to be_failure }
    end
  end
end
