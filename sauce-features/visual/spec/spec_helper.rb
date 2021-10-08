# frozen_string_literal: true

require 'selenium-webdriver'

RSpec.configure do |config|
  config.before do |example|
    options = Selenium::WebDriver::Options.chrome(browser_version: '94',
                                                  platform_name: 'Windows 10',
                                                  timeouts: {script: 90})
    options.add_option("sauce:options",
                       {name: example.full_description,
                        build: "Ruby-Visual-#{Time.now.to_i}",
                        username: ENV['SAUCE_USERNAME'],
                        accessKey: ENV['SAUCE_ACCESS_KEY']})
    options.add_option("sauce:visual",
                       {apiKey: ENV['SCREENER_API_KEY'],
                        projectName: 'Sauce Demo Ruby',
                        viewportSize: '1280x1024'})

    # On complex websites and browsers like internet explorer 11, you might need to increase
    # scripts and connection timeout in order for visual to be able to capture UI snapshot
    http_client = Selenium::WebDriver::Remote::Http::Default.new
    http_client.read_timeout = 90 # seconds

    skip('currently does not support Selenium 4')

    @driver = Selenium::WebDriver.for :remote,
                                      url: 'https://hub.screener.io/wd/hub',
                                      capabilities: options,
                                      http_client: http_client
  end

  config.after do
    unless @driver.nil?
      @driver.execute_script '/*@visual.end*/'
      @driver.quit
    end
  end
end
