=begin
    The 'require' definitions define which gems dependencies our script needs. In this example we have
    - The selenium-webdriver gem
    - The rspec framework gem
    - The sauce_whisk gem (a wrapper for the SauceLabs REST API)
=end
require 'selenium/webdriver'
require 'rspec'
describe "Instant_RSpec_Test1" do
    skip "is skipped" do
        it "should open safari" do |test|
            caps = {
                platform: 'macOS 10.13',
                browserName: 'Safari',
                version: '11.1',
                build: 'Onboarding Sample App - Ruby',
                name: '1-first-test'
            }
            driver = Selenium::WebDriver.for(:remote,
                                 url: 'https://SAUCE_USERNAME:SAUCE_ACCESS_KEY@ondemand.saucelabs.com:443/wd/hub',
                                 desired_capabilities: caps)
            driver.get('https://www.saucedemo.com')
            puts "title of webpage is: #{driver.title}"
            driver.quit
        end
    end
end