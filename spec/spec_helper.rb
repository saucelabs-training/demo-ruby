require "watir"
require_relative "support/sauce_helpers"

RSpec.configure do |config|
  config.include SauceHelpers

  config.before(:each) do |test|
    @browser = initialize_browser(test.full_description)
  end

  config.after(:each) do |example|
    submit_results(@browser.wd.session_id, !example.exception)
    @browser.quit
  end
end
