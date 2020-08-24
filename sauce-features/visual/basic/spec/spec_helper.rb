# frozen_string_literal: true

require 'selenium-webdriver'

RSpec.configure do |config|
  config.before do |example|
    caps = Selenium::WebDriver::Remote::W3C::Capabilities.new(browser_name: 'chrome',
                                                              browser_version: '80',
                                                              platform_name: 'MacOS 10.13',
                                                              "sauce:options": {name: example.full_description,
                                                                                build: "Ruby-Visual-#{Time.now.to_i}",
                                                                                username: ENV['SAUCE_USERNAME'],
                                                                                accessKey: ENV['SAUCE_ACCESS_KEY']},
                                                              "sauce:visual": {apiKey: ENV['SCREENER_API_KEY'],
                                                                               projectName: 'visual-e2e-test',
                                                                               viewportSize: '1280x1024'})

    # On complex websites and browsers like internet explorer 11, you migth need to increase
    # scripts and connection timeout in order for visual to be able to capture UI snapshot
    http_client = Selenium::WebDriver::Remote::Http::Default.new
    http_client.read_timeout = 90 # seconds
    @driver = Selenium::WebDriver.for :remote,
                                      url: 'https://hub.screener.io/wd/hub',
                                      desired_capabilities: caps,
                                      :http_client => http_client
    @driver.manage.timeouts.script_timeout = 90
  end

  config.after do
    @driver.execute_script '/*@visual.end*/'
    @driver.quit
  end
end
