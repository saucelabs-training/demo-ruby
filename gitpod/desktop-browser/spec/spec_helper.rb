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
    browser_name = ENV['BROWSER_NAME'] || 'chrome'
    browser_version = ENV['BROWSER_VERSION'] || 'latest'
    platform_name = ENV['PLATFORM_NAME']
    build = ENV['BUILD']
    region = ENV['REGION'] || 'us-west-1'
    name = example.full_description

    # Configure the desired capabilities
    options = Selenium::WebDriver::Options.send(browser_name)
    options.browser_version = browser_version
    options.platform_name = platform_name

    sauce_options = {name: name, build: build, username: username, accessKey: access_key, tags: ['gitpod']}
    options.add_option('sauce:options', sauce_options)

    # Configure the remote WebDriver
    url = "https://ondemand.#{region}.saucelabs.com:443/wd/hub"
    @driver = Selenium::WebDriver.for(:remote, url: url, capabilities: options)
  end

  config.after(:each) do |example|
    result = example.exception ? "failed" : "passed"
    @driver.execute_script("sauce:job-result=#{result}")
    @driver.quit
  end
end
