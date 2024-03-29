# frozen_string_literal: true

require 'capybara/cucumber'
require 'selenium-webdriver'
require 'sauce_whisk'

Before do |scenario|
  Capybara.register_driver :sauce do |app|
    url = 'https://ondemand.us-west-1.saucelabs.com:443/wd/hub'
    SauceWhisk.data_center = :US_WEST

    if ENV['PLATFORM_NAME'] == 'linux' # Then Headless
      url = 'https://ondemand.us-east-1.saucelabs.com:443/wd/hub'
      SauceWhisk.data_center = :US_EAST
    end

    browser_name = ENV['BROWSER_NAME'] || 'chrome'

    options = {browser_name: browser_name,
               platform_name: ENV['PLATFORM_NAME'] || 'Windows 10',
               browser_version: ENV['BROWSER_VERSION'] || 'latest',
               'sauce:options': {name: "#{scenario.feature.name} - #{scenario.name}",
                                 build: build_name,
                                 username: ENV['SAUCE_USERNAME'],
                                 access_key: ENV['SAUCE_ACCESS_KEY']}}

    caps = Selenium::WebDriver::Remote::Capabilities.send(browser_name, options)

    Capybara::Selenium::Driver.new(app,
                                   browser: :remote,
                                   url: url,
                                   capabilities: caps)
  end
  Capybara.current_driver = :sauce
end

After do |scenario|
  session_id = Capybara.current_session.driver.browser.session_id
  SauceWhisk::Jobs.change_status(session_id, scenario.passed?)
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
    "Ruby-Cucumber-Capybara: Local-#{Time.now.to_i}"
  end
end
