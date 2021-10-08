# frozen_string_literal: true

require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'rspec'
require 'sauce_whisk'

Capybara.default_max_wait_time = 10

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers

  config.before do |test|
    Capybara.register_driver :sauce do |app|
      url = 'https://ondemand.us-west-1.saucelabs.com:443/wd/hub'
      SauceWhisk.data_center = :US_WEST

      if ENV['PLATFORM_NAME'] == 'linux' # Then Headless
        url = 'https://ondemand.us-east-1.saucelabs.com:443/wd/hub'
        SauceWhisk.data_center = :US_EAST
      end

      browser_name = ENV['BROWSER_NAME'] || 'chrome'

      options = Selenium::WebDriver::Options.send(browser_name)
      options.platform_name = ENV['PLATFORM_NAME'] || 'Windows 10'
      options.browser_version = ENV['BROWSER_VERSION'] || 'latest'
      sauce_options = {name: test.full_description,
                       build: build_name,
                       username: ENV['SAUCE_USERNAME'],
                       access_key: ENV['SAUCE_ACCESS_KEY']}
      options.add_option('sauce:options', sauce_options)

      Capybara::Selenium::Driver.new(app,
                                     browser: :remote,
                                     url: url,
                                     capabilities: options)
    end
    Capybara.current_driver = :sauce
  end

  config.after do |test|
    session_id = Capybara.current_session.driver.browser.session_id
    SauceWhisk::Jobs.change_status(session_id, !test.exception)
    Capybara.current_session.quit
  end

  #
  # Note that this build name is specifically for Circle CI execution
  # Most CI tools have ENV variables that can be structured to provide useful build names
  #
  def build_name
    if ENV['CIRCLE_JOB']
      "#{ENV['CIRCLE_JOB']}: #{ENV['CIRCLE_BUILD_NUM']}"
    elsif ENV['SAUCE_BUILD_NAME']
      ENV['SAUCE_BUILD_NAME']
    else
      "Ruby-RSpec-Capybara: Local-#{Time.now.to_i}"
    end
  end
end
