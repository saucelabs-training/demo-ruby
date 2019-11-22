require "selenium-webdriver"
require "rspec"
require "sauce_whisk"

describe "Instant_RSpec_Test4" do
  before(:each) do |test|
    caps = {
        browser_name: 'chrome',
        platform_name: 'windows 10',
        browser_version: 'latest',
        "sauce:options" => {
            build: 'Onboarding Sample App - Ruby',
            name: '4-best-practices',
            seleniumVersion: '3.141.59',
            username: ENV['SAUCE_USERNAME'],
            accessKey: ENV['SAUCE_ACCESS_KEY'],
            # tags to filter test reporting.
            tags: ['instant-sauce', 'ruby-rspec', 'module4'],
            # setting sauce-runner specific parameters such as timeouts helps
            # manage test execution speed.
            maxDuration: 1800,
            commandTimeout: 300,
            idleTimeout: 1000
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
  after(:each) do |example|
    SauceWhisk::Jobs.change_status(@driver.session_id, !example.exception)
    @driver.quit
  end
end
