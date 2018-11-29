require "capybara"
require "capybara/rspec"
require "selenium-webdriver"
require "rspec"
require "sauce_whisk"

Capybara.default_max_wait_time = 10

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers

  def platforms
    YAML.safe_load(IO.read('spec/platforms.yml'))
  end

  def platform
    platforms[ENV['PLATFORM']] || platforms.first
  end

  def build_name
    if ENV['BUILD_NAME']
      ENV['BUILD_NAME']
    elsif ENV['TRAVIS_JOB_NUMBER']
      "#{ENV['TRAVIS_REPO_SLUG'][/[^\/]+$/]}: #{ENV['TRAVIS_JOB_NUMBER']}"
    elsif ENV['SAUCE_BAMBOO_BUILDNUMBER']
      ENV['SAUCE_BAMBOO_BUILDNUMBER']
    elsif ENV['CIRCLE_BUILD_NUM']
      "#{ENV['CIRCLE_JOB']}: #{ENV['CIRCLE_BUILD_NUM']}"
    elsif ENV['BUILD_TAG']
      ENV['BUILD_TAG']
    else
      "Local Execution - #{Time.now.to_i}"
    end
  end

  config.before(:each) do |example|
    Capybara.register_driver :sauce do |app|
      opt = {name: example.description,
             build: build_name,
             username: ENV['SAUCE_USERNAME'],
             accessKey: ENV['SAUCE_ACCESS_KEY']}

      opt.merge! platform
      caps = Selenium::WebDriver::Remote::Capabilities.send(opt.delete('browser_name').to_sym, opt)

      url = 'https://ondemand.saucelabs.com:443/wd/hub'

      @driver = Capybara::Selenium::Driver.new(app, {browser: :remote,
                                                     url: url,
                                                     desired_capabilities: caps})
    end
    Capybara.current_driver = :sauce
  end

  config.after(:each) do |example|
    SauceWhisk::Jobs.change_status(@driver.browser.session_id, !example.exception)
    @driver.quit
  end
end
