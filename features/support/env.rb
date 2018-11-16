require 'watir'
require 'rspec'
require_relative 'sauce_helpers'

include SauceHelpers

Before do |scenario|
  @browser = initialize_browser("#{scenario.feature.name} - #{scenario.name}")
end

After do |scenario|
  submit_results(@browser.wd.session_id, scenario.passed?)
  @browser.quit
end
