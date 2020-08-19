# frozen_string_literal: true

require 'selenium-webdriver'
require 'sauce_whisk'

RSpec.configure do |config|
  config.before do |example|
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
               'sauce:options': {name: example.full_description,
                                 build: build_name,
                                 username: ENV['SAUCE_USERNAME'],
                                 access_key: ENV['SAUCE_ACCESS_KEY']}}

    capabilities = Selenium::WebDriver::Remote::Capabilities.send(browser_name, options)
    @driver = Selenium::WebDriver.for(:remote,
                                      url: url,
                                      desired_capabilities: capabilities)
  end

  config.after do |example|
    SauceWhisk::Jobs.change_status(@driver.session_id, !example.exception)
    @driver.quit
  end

  #
  # Note that this build name is specifically for Circle CI execution
  # Most CI tools have ENV variables that can be structured to provide useful build names
  #
  def build_name
    if ENV['CIRCLE_JOB']
      "#{ENV['CIRCLE_JOB']}: #{ENV['CIRCLE_BUILD_NUM']}"
    elsif ENV['TRAVIS_REPO_SLUG']
      "#{ENV['TRAVIS_REPO_SLUG'][%r{[^/]+$}]}: #{ENV['TRAVIS_JOB_NUMBER']}"
    elsif ENV['SAUCE_START_TIME']
      ENV['SAUCE_START_TIME']
    else
      "Ruby-RSpec-Selenium: Local-#{Time.now.to_i}"
    end
  end
end
