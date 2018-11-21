require "spec_helper"

describe "Authentication" do
  before { visit 'http://www.saucedemo.com' }

  it "successful" do
    fill_in 'Username', with: 'standard_user'
    fill_in 'Password', with: 'secret_sauce'

    click_button('LOGIN')

    expect(page).to have_current_path('https://www.saucedemo.com/inventory.html')
  end
end
