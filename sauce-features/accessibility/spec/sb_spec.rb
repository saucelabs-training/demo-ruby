# frozen_string_literal: true

require 'rspec'
require 'sauce_bindings'

describe 'Sauce Bindings Accessibility' do
  before do
    @session = SauceBindings::Session.new
    @driver = @session.start
  end

  after do
    @session.stop(true)
  end

  it '#analyze' do
    @driver.navigate.to('https://www.saucedemo.com')
    @session.accessibility_results
  end
end
