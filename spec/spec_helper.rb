require "watir"
require_relative "support/sauce_helpers"

RSpec.configure do |config|
  config.include SauceHelpers

  config.before(:each) do |test|
    initialize_browser(test.full_description)
  end

  config.after(:each) do |example|
    submit_results(@driver.session_id, !example.exception)
    @driver.quit
  end
end
