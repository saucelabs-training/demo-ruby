# frozen_string_literal: true

require "selenium-webdriver"
require 'sauce_whisk'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do |example|
    metadata = example.metadata

    browser = metadata[:browser] || :chrome
    opts = Selenium::WebDriver::Options.send(browser, platform_name: 'Windows 10')
    sauce_options = {name: example.full_description,
                     username: ENV['SAUCE_USERNAME'],
                     access_key: ENV['SAUCE_ACCESS_KEY']}

    opts.headless! if metadata[:headless]
    opts.prefs = metadata[:prefs] if metadata[:prefs]

    opts.add_option("sauce:options", sauce_options)

    unless metadata[:unit]
      @driver = Selenium::WebDriver.for(:remote,
                                        url: 'https://ondemand.us-west-1.saucelabs.com/wd/hub/',
                                        capabilities: opts)
    end
  end

  config.after do |example|
    unless @driver.nil?
      SauceWhisk::Jobs.change_status(@driver.session_id, !example.exception)
      @driver.quit
    end
  end
end
