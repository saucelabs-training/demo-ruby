# frozen_string_literal: true

#
# This is an example of Imperative Test code to keep things simple
# Your tests should be written declaritively
# This means adding abstractions for Page Objects and Data Objects that will do all of the work.
#
require 'spec_helper'

describe 'Authentication' do
  before { @driver.get 'https://www.saucedemo.com' }

  it 'successful' do
    @driver.find_element(css: "[data-test='username']").send_keys 'standard_user'
    @driver.find_element(css: "[data-test='password']").send_keys 'secret_sauce'
    @driver.find_element(css: "[type='submit']").click

    expect(@driver.current_url).to eq 'https://www.saucedemo.com/inventory.html'
  end
end
