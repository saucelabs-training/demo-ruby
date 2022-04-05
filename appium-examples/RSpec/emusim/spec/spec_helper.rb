require 'appium_lib'
require 'rspec'
require 'sauce_whisk'

RSpec.configure do |config|
  GH_RELEASE = 'https://github.com/saucelabs/my-demo-app-rn/releases/download/v1.2.0'.freeze

  config.before(:each) do |example|
    platform = example.metadata[:platform]
    caps = send("#{platform}_caps")

    caps['sauce:options'] = {}
    caps['sauce:options'][:appiumVersion] = '1.22.1'
    caps['sauce:options'][:name] = example.full_description
    caps['sauce:options'][:build] = ENV['SAUCE_BUILD_NAME'] || "Ruby EmuSim Local - #{Time.now.to_i}"

    appium = {sauce_endpoint: 'ondemand.us-west-1.saucelabs.com/wd/hub'}
    @options = {caps: caps, appium_lib: appium}

    @driver = Appium::Driver.new @options, false
    @driver.start_driver
  end

  config.after(:each) do |example|
    if @driver&.driver
      sessionid = @driver.session_id
      @driver.driver_quit
      puts "SauceOnDemandSessionID=#{sessionid} job-name=#{example.full_description}"

      SauceWhisk::Jobs.change_status(sessionid, passed: !example.exception)
    end
  end
end

def ios_caps
  caps = {}
  caps[:platform_name] = 'iOS'
  caps['appium:app'] = "#{GH_RELEASE}/iOS-Simulator-MyRNDemoApp.1.2.0-152.zip"
  caps['appium:deviceName'] = ENV['DEVICE_NAME'] || 'iPhone Simulator'
  caps['appium:platformVersion'] = '15.2'
  caps
end

def android_caps
  caps = {}
  caps[:platform_name] = 'Android'
  caps['appium:app'] = "#{GH_RELEASE}/Android-MyDemoAppRN.1.2.0.build-231.apk"
  caps['appium:deviceName'] = ENV['DEVICE_NAME'] || 'Android GoogleAPI Emulator'
  caps['appium:platformVersion'] = '12'
  caps
end

def web_caps
  caps = {}
  caps[:browser_name] = ENV['BROWSER_NAME'] || 'Chrome'
  caps[:platform_name] = ENV['PLATFORM_NAME'] || 'Android'
  caps['appium:deviceName'] = ENV['DEVICE_NAME'] || 'Android GoogleAPI Emulator'
  caps['appium:platformVersion'] = '12'
  caps
end
