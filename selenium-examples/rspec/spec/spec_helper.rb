# frozen_string_literal: true

require 'selenium-webdriver'
require 'sauce_whisk'

# This test code is being used in docs: https://docs.saucelabs.com/web-apps/automated-testing/selenium/
RSpec.configure do |config|
  config.before do |example|
    options = Selenium::WebDriver::Options.send(ENV['BROWSER_NAME'] || 'chrome')
    options.platform_name = ENV['PLATFORM_NAME'] || 'Windows 10'
    options.browser_version = ENV['BROWSER_VERSION'] || 'latest'
    sauce_options = {name: example.full_description,
                     build: build_name,
                     username: ENV['SAUCE_USERNAME'],
                     access_key: ENV['SAUCE_ACCESS_KEY']}
    options.add_option('sauce:options', sauce_options)

    @driver = Selenium::WebDriver.for(:remote,
                                      url: 'https://ondemand.us-west-1.saucelabs.com/wd/hub',
                                      capabilities: options)
  end

  config.after do |example|
    result = example.exception ? "failed" : "passed"
    @driver.execute_script("sauce:job-result=#{result}")
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
    elsif ENV['SAUCE_BUILD_NAME']
      ENV['SAUCE_BUILD_NAME']
    else
      "Ruby-RSpec-Selenium: Local-#{Time.now.to_i}"
    end
  end
end
