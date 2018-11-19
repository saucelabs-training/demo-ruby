require 'selenium-webdriver'
require 'rspec'
require_relative 'sauce_helpers'

include SauceHelpers

Before do |scenario|
  initialize_browser("#{scenario.feature.name} - #{scenario.name}")
end

After do |scenario|
  submit_results(@driver.session_id, scenario.passed?)
  @driver.quit
end
