# frozen_string_literal: true

require 'selenium-webdriver'
require 'sauce_whisk'

RSpec.configure do |config|
  config.before do |example|
    create_session(example.full_description)
  end

  config.after do |example|
    end_session(!example.exception)
  end

  def create_session(test_name)
    # Sauce has multiple data centers, need to specify;
    # Options are :US_WEST :EU_VDC and :US_EAST (for headless)
    SauceWhisk.data_center = ENV['SAUCE_DC']&.to_sym || :US_WEST

    # Ideal implementation is to set 'PLATFORM' environment variable in a Rake task, but we always include a defualt
    options = platform(ENV['PLATFORM'] || 'mac_sierra_chrome')

    options['sauce:options'] = {name: test_name,
                                build: build_name,
                                username: ENV['SAUCE_USERNAME'],
                                access_key: ENV['SAUCE_ACCESS_KEY']}

    # Make sure URL and Data Center value above match
    url = ENV['SAUCE_URL'] || 'https://ondemand.saucelabs.com:443/wd/hub'

    browser = options.delete(:browser_name).to_sym
    capabilities = Selenium::WebDriver::Remote::Capabilities.send(browser, options)
    @driver = Selenium::WebDriver.for(:remote, url: url,
                                               desired_capabilities: capabilities)
  end

  def end_session(result)
    SauceWhisk::Jobs.change_status(@driver.session_id, result)
    @driver.close
  end

  # Ideal implementation is to do a lookup from a YAML file or the like rather than using a switch implementation
  def platform(platform_key)
    case platform_key
    when 'windows_10_edge'
      {platform_name: 'Windows 10',
       browser_name: 'edge',
       browser_version: '18.17763'}
    when 'windows_8_ie'
      {platform: 'Windows 8.1',
       browser_name: 'ie',
       version: '11.0'}
    when 'mac_sierra_chrome'
      {platform_name: 'macOS 10.12',
       browser_name: 'chrome',
       browser_version: '75.0'}
    when 'mac_mojave_safari'
      {platform_name: 'macOS 10.14',
       browser_name: 'safari',
       browser_version: '12.0'}
    when 'windows_7_ff'
      {platform_name: 'Windows 7',
       browser_name: 'firefox',
       browser_version: '60.0'}
    when 'headless'
      {platform_name: 'Linux',
       browser_name: 'chrome'}
    end
  end

  #
  # Note that this build name is specifically for Travis CI execution
  # Most CI tools have ENV variables that can be structured to provide useful build names
  #
  def build_name
    if ENV['BUILD_TAG']
      ENV['BUILD_TAG']
    elsif ENV['TRAVIS_REPO_SLUG']
      "#{ENV['TRAVIS_REPO_SLUG'][%r{[^/]+$}]}: #{ENV['TRAVIS_JOB_NUMBER']}"
    elsif ENV['SAUCE_START_TIME']
      ENV['SAUCE_START_TIME']
    else
      "Ruby-RSpec-Selenium: Local-#{Time.now.to_i}"
    end
  end
end
