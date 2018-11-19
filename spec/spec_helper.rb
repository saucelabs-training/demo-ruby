require "capybara"
require "capybara/rspec"
require "selenium-webdriver"
require "rspec"
require "sauce_whisk"
require_relative "support/sauce_helpers"

Capybara.default_max_wait_time = 10

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
  config.include SauceHelpers

  config.before(:each) do |example|
    initialize_browser(example.description)
  end

  config.after(:each) do |example|
    session_id = @driver.browser.session_id
    submit_results(session_id, !example.exception)
    @driver.quit
  end
end
