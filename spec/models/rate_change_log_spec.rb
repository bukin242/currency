require 'rails_helper'

describe RateChangeLog, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_numericality_of(:value).is_greater_than(0) }
  end

  context '.last_rate' do
    let!(:rate1) { create :rate_change_log, value: 1 }
    let!(:rate2) { create :rate_change_log, value: 2, created_at: 1.day.ago }

    subject { described_class.last_rate }

    it { expect(subject).to eq 1 }
  end
end
