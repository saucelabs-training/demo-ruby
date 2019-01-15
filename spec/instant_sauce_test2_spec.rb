require 'selenium/webdriver'
require 'rspec'

=begin
    The basic structure of RSpec uses 'describe' and 'it' to format our script in a conversational tone.
    'describe' represents the highest context, for example if we were testing authentication features it would say something like: '.authentication', and the 'it' would say something like 'should login'
=end
describe "Instant_RSpec_Test2" do
=begin
  'it' represents the business-level logic that we're testing,
  in this case we're checking to see if our test in SauceLabs session can open Chrome using W3C, then check the title page.
=end
  it "should_open_safari" do |test|

    caps = {
        # the caps object allows us to pass test metadata to the VM such as:
        # broswer_name, platform_version, browser_version, etc.
        browser_name: 'Safari',
        platform_version: 'macOS 10.13',
        browser_version: '11.1',
        # the sauce:options field allows us to define sauce labs-specific test parameters
        # such as: sauce username and access key, timeouts, selenium version etc.
        "sauce:options" => {
            name: test.full_description,
            seleniumVersion: '3.141.59',
            username: ENV['SAUCE_USERNAME'],
            accessKey: ENV['SAUCE_ACCESS_KEY']
        }
    }
    driver = Selenium::WebDriver.for(:remote,
                                     url: 'https://ondemand.saucelabs.com:443/wd/hub',
                                     desired_capabilities: caps)
    driver.get('https://www.saucedemo.com')
    puts "title of webpage is: #{driver.title}"
    driver.quit
  end
end