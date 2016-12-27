require "capybara"
require "capybara/rspec"
require "rspec"
require "sauce_whisk"


Capybara.default_max_wait_time = 10

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers

  config.before(:each) do |example|
    Capybara.register_driver :selenium do |app|
      capabilities = {
          version: ENV['version'],
          browserName: ENV['browserName'],
          platform: ENV['platform'],
          name: example.description,
          build: ENV['BUILD_TAG'] || "Unknown Build"
      }
      url = "https://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:443/wd/hub".strip

      Capybara::Selenium::Driver.new(app, {browser: :remote,
                                           url: url,
                                           desired_capabilities: capabilities})
    end
    Capybara.current_driver = :selenium
  end


  config.after(:each) do |example|
    session_id = ::Capybara.current_session.driver.browser.session_id
    ::Capybara.current_session.driver.quit

    SauceWhisk::Jobs.change_status(session_id, example.exception.nil?)
  end
end
