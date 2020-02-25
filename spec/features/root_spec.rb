require 'rails_helper'

RSpec.feature "/", type: :feature do
  scenario 'rate has been set' do
    create :rate_change_log, value: 50

    visit root_path
    expect(page).to have_content '1 USD = 50.0'
  end

  scenario 'rate not set' do
    visit root_path
    expect(page).to have_content '1 USD = ...'
  end
end
