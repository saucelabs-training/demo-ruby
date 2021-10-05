# frozen_string_literal: true

require 'watir'
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
               url: url,
               'sauce:options': {name: example.full_description,
                                 build: build_name,
                                 username: ENV['SAUCE_USERNAME'],
                                 access_key: ENV['SAUCE_ACCESS_KEY']}}

    @browser = Watir::Browser.new browser_name, options
  end

  config.after do |example|
    SauceWhisk::Jobs.change_status(@browser.wd.session_id, !example.exception)

    @browser.quit
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
      "Ruby-Watir-Selenium: Local-#{Time.now.to_i}"
    end
  end
end
