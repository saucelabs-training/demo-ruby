require 'capybara/cucumber'
require 'selenium-webdriver'

def platforms
  YAML.safe_load(IO.read('platforms.yml'))
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

Before do |scenario|
  Capybara.register_driver :sauce do |app|
    opt = {name: "#{scenario.feature.name} - #{scenario.name}",
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

After do |scenario|
  SauceWhisk::Jobs.change_status(@driver.browser.session_id, scenario.passed?)
  @driver.quit
end
