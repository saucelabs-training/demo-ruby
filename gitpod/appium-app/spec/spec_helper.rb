require 'selenium-webdriver'
require 'rspec'

RSpec.configure do |config|
  config.before(:each) do |example|
    username = ENV['SAUCE_USERNAME']
    access_key = ENV['SAUCE_ACCESS_KEY']
    if (!username || !access_key)
      puts "Please set the SAUCE_USERNAME and SAUCE_ACCESS_KEY environment variables at https://gitpod.io/user/variables and try again."
      puts "To find your Sauce Labs access key, visit https://app.saucelabs.com/user-settings."
      exit
    end
    browser_name = ENV['BROWSER_NAME']
    app_name = ENV['APP_NAME']
    device_name = ENV['DEVICE_NAME']
    platform_name = ENV['PLATFORM_NAME'] || 'iOS'
    platform_version = ENV['PLATFORM_VERSION']
    build = ENV['BUILD']
    automation_name = ENV['AUTOMATION_NAME'] || 'xcuitest'
    region = ENV['REGION'] || 'us-west-1'
    name = example.full_description
    
    caps = Selenium::WebDriver::Remote::Capabilities.new
    caps[:platform_name] = platform_name
    caps[:browser_name] = browser_name
    caps['appium:app'] = app_name
    caps['appium:deviceName'] = device_name
    caps['appium:automationName'] = automation_name
    caps['appium:platformVersion'] = platform_version
    caps['sauce:options'] = {}
    caps['sauce:options'][:username] = username
    caps['sauce:options'][:accessKey] = access_key
    caps['sauce:options'][:build] = build
    caps['sauce:options'][:name] = name
    
    url = "https://ondemand.#{region}.saucelabs.com:443/wd/hub";
    @driver = Selenium::WebDriver.for(:remote, :url => url, :desired_capabilities => caps)    
  end

  config.after(:each) do |example|
    result = example.exception ? "failed" : "passed"
    @driver.execute_script("sauce:job-result=#{result}")
    @driver.quit
  end
end
