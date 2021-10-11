# frozen_string_literal: true

#
# This is an example of Imperative Test code to keep things simple
# Your tests should be written declaratively
# This means adding abstractions for Page Objects and Data Objects that will do all of the work.
#
require 'spec_helper'

# This test code is being used in docs: https://docs.saucelabs.com/web-apps/automated-testing/selenium/
describe 'Authentication' do
  it 'successful' do
    @driver.get 'https://www.saucedemo.com'

    username_locator = {css: '#user-name'}
    password_locator = {css: '#password'}
    submit_locator = {css: '.btn_action'}

    wait = Selenium::WebDriver::Wait.new()
    wait.until { @driver.find_element(username_locator).displayed? }

    username_element = @driver.find_element(username_locator)
    password_element = @driver.find_element(password_locator)
    submit_element = @driver.find_element(submit_locator)

    username_element.send_keys 'standard_user'
    password_element.send_keys 'secret_sauce'
    submit_element.click

    expect(@driver.current_url).to eq 'https://www.saucedemo.com/inventory.html'
  end
end
