require "spec_helper"

describe "Authentication" do
  before { visit 'http://www.saucedemo.com' }

  it "fails" do
    fill_in 'Username', with: 'locked_out_user'
    fill_in 'Password', with: 'secret_sauce'

    click_button('LOGIN')

    expect(page).to have_css('.error-button')
  end
end
