require 'rails_helper'

RSpec.feature "admin/custom_rate/new", type: :feature do
  scenario 'fill custom rate' do
    visit new_admin_custom_rate_path
    fill_in 'custom_rate[rate_value]', with: 50.to_s
    fill_in 'custom_rate[expire_time]', with: 1.day.from_now.to_s
    click_button 'save'

    visit root_path
    expect(page).to have_content '1 USD = 50.0'
  end
end
