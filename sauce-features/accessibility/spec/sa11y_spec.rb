# frozen_string_literal: true
require 'rspec'
require 'selenium-webdriver'
require 'sa11y/analyze'

describe 'Sa11y Accessibility' do
  before do
    opts = {browser_name: 'chrome',
            "sauce:options": {name: "Sally::Analyze#results",
                              username: ENV['SAUCE_USERNAME'],
                              accessKey: ENV['SAUCE_ACCESS_KEY']}}
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(opts)

    @driver = Selenium::WebDriver.for :remote,
                                      url: 'https://ondemand.us-west-1.saucelabs.com/wd/hub',
                                      capabilities: caps
  end

  after do
    @driver.quit
  end

  it '#results' do
    @driver.navigate.to('https://www.saucedemo.com')
    Sa11y::Analyze.new(@driver).results
  end
end
