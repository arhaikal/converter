require 'rails_helper'
require 'factory_girl_rails'

feature 'Exchange' do
  before :each do
      User.create(email: 'user@example.com', password: 'password')
  end

  scenario 'user can create an exchange' do
    create(:historical_rate)
    create(:rate)
    sign_in
    click_link "Create a new exchange"

    within("#new-exchange") do
      fill_in 'exchange_amount', with: 100
      select("USD", from: "exchange_base_currency").select_option
      select('EUR', from: 'exchange_target_currency').select_option
      fill_in 'exchange_waiting_time', with: 1
      click_button "Create Exchange"
    end

    expect(page).to have_content("Results for Exchange")
  end

  def sign_in
    visit root_path
    fill_in "user[email]", with: "user@example.com"
    fill_in "user[password]", with: "password"
    click_button "Log in"
  end
end
