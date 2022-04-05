require 'rspec/expectations'
require 'appium_lib'
require 'rspec/retry'

RSpec.configure do |config|
  GH_RELEASE = 'https://github.com/saucelabs/my-demo-app-rn/releases/download/v1.2.0'.freeze

  config.exceptions_to_retry = [Selenium::WebDriver::Error::UnknownError, Selenium::WebDriver::Error::ServerError]
  config.default_retry_count = 4
  config.verbose_retry = true

  config.before(:each) do |example|
    platform = example.metadata[:platform]
    caps = send("#{platform}_caps")
    caps['appium:platformVersion'] = '12'

    caps['sauce:options'] = {}
    caps['sauce:options'][:appiumVersion] = '1.22.1'
    caps['sauce:options'][:name] = example.full_description
    caps['sauce:options'][:build] = ENV['SAUCE_BUILD_NAME'] || "Ruby RDC Local - #{Time.now.to_i}"

    appium = {sauce_endpoint: 'ondemand.us-west-1.saucelabs.com/wd/hub'}

    @options = {caps: caps, appium_lib: appium}

    @driver = Appium::Driver.new @options, false
    @driver.start_driver
  end

  config.after(:each) do |example|
    if @driver&.driver
      @driver.execute_script("sauce:job-result=#{!example.exception}")
      @driver.driver_quit
    end
  end
end

def ios_caps
  caps = {}
  caps[:platform_name] = 'iOS'
  caps['appium:app'] = "#{GH_RELEASE}/iOS-Real-Device-MyRNDemoApp.1.2.0-150.ipa"
  caps['appium:deviceName'] = ENV['DEVICE_NAME'] || 'iPhone .*'
  caps
end

def android_caps
  caps = {}
  caps[:platform_name] = 'Android'
  caps['appium:app'] = "#{GH_RELEASE}/Android-MyDemoAppRN.1.2.0.build-231.apk"
  caps['appium:deviceName'] = ENV['DEVICE_NAME'] || 'samsung.*'
  caps
end

def web_caps
  caps = {}
  caps[:browser_name] = ENV['BROWSER_NAME'] || 'chrome'
  caps[:platform_name] = ENV['PLATFORM_NAME'] || 'Android'
  caps['appium:deviceName'] = ENV['DEVICE_NAME'] || 'samsung.*'
  caps
end
