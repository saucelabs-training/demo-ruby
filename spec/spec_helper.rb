# frozen_string_literal: true

require 'watir'
require 'sauce_whisk'

RSpec.configure do |config|
  config.before(:each) do |example|
    options = platform(example.full_description)

    browser = options.delete(:browser_name)

    @browser = Watir::Browser.new browser, options
  end

  config.after(:each) do |example|
    SauceWhisk::Jobs.change_status(@browser.wd.session_id, !example.exception)

    @browser.quit
  end

  #
  # Note that having this as a conditional in the test code is less ideal
  # It is better for static data to be pulled from a serialized file like a yaml
  #
  # Note: not all browsers are defaulting to using w3c protocol
  # This will change soon. Where possible prefer the w3c approach
  #
  def platform(name)
    ENV['PLATFORM'] ||= 'mac_sierra_chrome'
    SauceWhisk.data_center = :US_WEST

    case ENV['PLATFORM']
    when 'windows_10_edge'
      common_params(name).merge(platform_name: 'Windows 10',
                                browser_name: 'edge')
    when 'windows_8_ie'
      common_params(name).merge(platform: 'Windows 8.1',
                                browser_name: 'ie')
    when 'mac_sierra_chrome'
      common_params(name).merge(platform_name: 'macOS 10.12',
                                browser_name: 'chrome')
    when 'mac_mojave_safari'
      common_params(name).merge(platform_name: 'macOS 10.14',
                                browser_name: 'safari')
    when 'windows_7_ff'
      common_params(name).merge(platform_name: 'Windows 7',
                                browser_name: 'firefox')
    when 'headless'
      SauceWhisk.data_center = :US_EAST
      common_params(name).merge(platform_name: 'Linux',
                                browser_name: 'chrome',
                                url: 'https://ondemand.us-east-1.saucelabs.com:443/wd/hub')
    end
  end

  def common_params(name)
    {url: 'https://ondemand.saucelabs.com:443/wd/hub',
     browser_version: 'latest',
     'sauce:options' => {name: name,
                         build: build_name,
                         username: ENV['SAUCE_USERNAME'],
                         access_key: ENV['SAUCE_ACCESS_KEY']}}
  end

  #
  # Note that this build name is specifically for Travis CI execution
  # Most CI tools have ENV variables that can be structured to provide useful build names
  #
  def build_name
    if ENV['TRAVIS_REPO_SLUG']
      "#{ENV['TRAVIS_REPO_SLUG'][%r{[^/]+$}]}: #{ENV['TRAVIS_JOB_NUMBER']}"
    elsif ENV['SAUCE_START_TIME']
      ENV['SAUCE_START_TIME']
    else
      "Ruby-Watir-Selenium: Local-#{Time.now.to_i}"
    end
  end
end
