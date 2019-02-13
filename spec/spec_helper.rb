require "selenium-webdriver"
require "sauce_whisk"

RSpec.configure do |config|

  config.before(:each) do |test|
    options = platform(test.full_description)

    browser = options.delete(:browser_name)
    capabilities = Selenium::WebDriver::Remote::Capabilities.send(browser, options)
    url = "https://ondemand.saucelabs.com:443/wd/hub"

    @driver = Selenium::WebDriver.for(:remote, url: url, desired_capabilities: capabilities)
  end

  config.after(:each) do |example|
    SauceWhisk::Jobs.change_status(@driver.session_id, !example.exception)
    @driver.quit
  end

  #
  # Note that having this as a conditional in the test code is less ideal
  # It is better for static data to be pulled from a serialized file like a yaml
  #
  def platform(name)
    case ENV['PLATFORM']
    when 'windows_10_edge'
      {selenium_version: '3.141.59',
       platform: 'Windows 10',
       browser_name: 'edge',
       version: '16.16299'}.merge(sauce_oss name)
    when 'windows_8_ie'
      # Note: w3c is not working for Windows 8 & IE 11
      {platform: 'Windows 8.1',
       browser_name: 'ie',
       selenium_version: '3.141.59',
       version: '11.0'}.merge(sauce_oss name)
    when 'mac_sierra_chrome'
      # This is for running with w3c which is not yet the default
      #   {platform_name: 'macOS 10.12',
      #    browser_name: 'chrome',
      #    "goog:chromeOptions": {w3c: true},
      #    browser_version: '65.0'}.merge(sauce_w3c name)
      {selenium_version: '3.141.59',
       platform: 'macOS 10.12',
       browser_name: 'chrome',
       version: '65.0'}.merge(sauce_oss name)
    when 'mac_mojave_safari'
      {platform_name: 'macOS 10.14',
       browser_name: 'safari',
       browser_version: '12.0'}.merge(sauce_w3c name)
    when 'windows_7_ff'
      {platform_name: 'Windows 7',
       browser_name: 'firefox',
       browser_version: '60.0'}.merge(sauce_w3c name)
    else
      # Always specify a default
      {selenium_version: '3.141.59',
       platform: 'macOS 10.12',
       browser_name: 'chrome',
       version: '65.0'}.merge(sauce_oss name)
    end
  end

  def sauce_w3c(name)
    w3c_opts = sauce_oss(name)
    w3c_opts[:selenium_version] = '3.141.59'
    {'sauce:options' => w3c_opts}
  end

  def sauce_oss(name)
    {name: name,
     username: ENV['SAUCE_USERNAME'],
     access_key: ENV['SAUCE_ACCESS_KEY']}
  end
end
