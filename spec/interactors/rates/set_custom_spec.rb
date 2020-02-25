require 'rails_helper'

describe Rates::SetCustom do
  context '.call' do
    subject { described_class.call(rate_value: rate_value, expire_time: expire_time.to_s) }

    context 'when valid params' do
      let(:rate_value) { 50 }
      let(:expire_time) { 1.day.from_now }

      it { expect(subject).to be_success }

      context 'when set in redis' do
        after { subject }
        it { expect(Redis.current).to receive(:set).with(RateChangeLog::CUSTOM_RATE_KEY, 50) }
      end
    end

    context 'when ivalid params' do
      context 'when rate value' do
        let(:expire_time) { 1.day.from_now }

        context 'when blank' do
          let(:rate_value) { '' }
          it { expect(subject).to be_failure }
        end

        context 'when not correct' do
          let(:rate_value) { 'abc' }
          it { expect(subject).to be_failure }
        end
      end

      context 'when expire time' do
        let(:rate_value) { 50 }

        context 'when blank' do
          let(:expire_time) { '' }
          it { expect(subject).to be_failure }
        end

        context 'when not correct' do
          let(:expire_time) { 'abc' }
          it { expect(subject).to be_failure }
        end

        context 'when time less now' do
          let(:expire_time) { 1.day.ago }
          it { expect(subject).to be_failure }
        end
      end
    end
  end
end
