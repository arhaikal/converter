require 'rails_helper'
require 'factory_girl_rails'

feature 'Sign in' do
  let(:user) { FactoryGirl.create(:user) }


  scenario 'visiting the site to sign in' do
    visit root_path
    sign_in(user.email, user.password)

    expect(page).to have_content("Exchangify")
  end

  scenario "Signing with a wrong password" do
    visit root_path
    sign_in(user.email, "123456")

    expect(page).to have_content("Log in")
  end

  def sign_in(email, password)
    fill_in "user[email]", with: email
    fill_in "user[password]", with: password
    click_button "Log in"
  end
end
