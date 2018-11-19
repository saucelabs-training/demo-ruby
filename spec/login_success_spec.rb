require "spec_helper"

describe "Authentication" do
  before { @driver.get 'http://www.saucedemo.com' }

  it "successful" do
    @driver.find_element(css: "[data-test='username']").send_keys 'standard_user'
    @driver.find_element(css: "[data-test='password']").send_keys 'secret_sauce'
    @driver.find_element(css: "[type='submit']").click

    expect(@driver.current_url).to eq 'https://www.saucedemo.com/inventory.html'
  end
end
