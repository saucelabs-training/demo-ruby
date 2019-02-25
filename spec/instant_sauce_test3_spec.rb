require "selenium-webdriver"
require "rspec"
require "sauce_whisk"

describe "Instant_RSpec_Test3" do

=begin
    'before is an RSpec method that allows us to define prerequisite test execution steps such as:
        - defining the browser name
        - defining the browser version
        - defining the OS version and platform
        - defining the sauce:options capabilities, in this case the test name, the SauceLabs credentials, and the selenium version
=end

  before(:each) do |test|
    caps = {
        browser_name: 'chrome',
        # platform_version now becomes platform_name with the W3C bridge.
        # For more details see: https://www.rubydoc.info/gems/selenium-webdriver/Selenium/WebDriver/Remote/W3C/Capabilities
        platform_name: 'windows 10',
        browser_version: '71.0',
        # w3c is note enabled by default in Chrome, set the w3c setting to true
        "goog:chromeOptions" => {w3c: true},
        # use sauce:options to handle all saucelabs.com-specific capabilities such as:
        # username, accesskey, build number, test name, timeouts etc.
        "sauce:options" => {
            build: 'Onboarding Sample App - Ruby',
            name: '3-cross-browser',
            seleniumVersion: '3.141.59',
            username: ENV['SAUCE_USERNAME'],
            accessKey: ENV['SAUCE_ACCESS_KEY']
        }
    }
    @driver = Selenium::WebDriver.for(:remote,
                                      url: 'https://ondemand.saucelabs.com:443/wd/hub',
                                      desired_capabilities: caps)
  end
  it "should_open_chrome" do
    @driver.get('https://www.saucedemo.com')
    puts "title of webpage is: #{@driver.title}"
  end
=begin
    Here we use 'after' which is another RSpec method that handles all postrequisite test execution steps such as:
        - sending the results to SauceLabs.com
        - Tearing down the current RemoteWebDriver session so that the test VM doesn't hang
=end
  after(:each) do |example|
    # SauceWhisk::Jobs is a Ruby wrapper for the SauceLabs REST API. Here we're updating the job method
    # For more info please visit the Sauce Labs REST API Documentation: https://wiki.saucelabs.com/display/DOCS/Job+Methods
    SauceWhisk::Jobs.change_status(@driver.session_id, !example.exception)
    @driver.quit
  end
end