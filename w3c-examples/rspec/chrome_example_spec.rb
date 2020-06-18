# The 'require' definitions define which gems dependencies our script needs. In this example we have
# - The selenium-webdriver gem
# - The rspec framework gem
# - The sauce_whisk gem (a wrapper for the SauceLabs REST API)

require "selenium-webdriver"
require "rspec"
require "sauce_whisk"

# The basic structure of RSpec uses 'describe' and 'it' to format our script in a conversational tone.
# 'describe' represents the highest context, for example if we were testing authentication features it would say something like: '.authentication', and the 'it' would say something like 'should login'

describe "W3C RSpec Test" do

  # before is an RSpec method that allows us to define prerequisite test execution steps such as:
  #     - defining the browser name
  #     - defining the browser version
  #     - defining the OS version and platform
  #     - defining the sauce:options capabilities, in this case the test name, the SauceLabs credentials, and the selenium version

  before(:each) do |test|
    caps = {
        browser_name: 'chrome',
        # platform_version now becomes platform_name with the W3C bridge.
        # For more details see: https://www.rubydoc.info/gems/selenium-webdriver/Selenium/WebDriver/Remote/W3C/Capabilities
        platform_name: 'windows 10',
        browser_version: '61.0',
        # w3c is note enabled by default in Chrome (in Chrome < 75), set the w3c setting to true
        "goog:chromeOptions" => {w3c: true},
        # use sauce:options to handle all saucelabs.com-specific capabilities such as:
        # username, accesskey, build number, test name, timeouts etc.
        "sauce:options" => {
            name: test.full_description,
            selenium_version: '3.141.59',
            build: 'w3c-ruby-tests-1.0.0',
            username: ENV['SAUCE_USERNAME'],
            access_key: ENV['SAUCE_ACCESS_KEY']
        }
    }
    @driver = Selenium::WebDriver.for(:remote,
                                      url: 'https://ondemand.saucelabs.com:443/wd/hub',
                                      desired_capabilities: caps)
  end

  # Again, 'it' represents the business-level logic that we're testing,
  # in this case we're checking to see if our test in SauceLabs session can open Chrome using W3C, then check the title page.

  it "should_open_chrome" do
    @driver.get('https://www.saucedemo.com')
    puts "title of webpage is: #{@driver.title}"
  end

  # Here we use 'after' which is another RSpec method that handles all postrequisite test execution steps such as:
  #     - sending the results to SauceLabs.com
  #     - Tearing down the current RemoteWebDriver session so that the test VM doesn't hang

  after(:each) do |example|
    # SauceWhisk::Jobs is a Ruby wrapper for the SauceLabs REST API. Here we're updating the job method
    # For more info please visit the Sauce Labs REST API Documentation: https://wiki.saucelabs.com/display/DOCS/Job+Methods
    SauceWhisk::Jobs.change_status(@driver.session_id, !example.exception)
    @driver.quit
  end
end
