# frozen_string_literal: true

require_relative 'visual_helper'

describe 'Visual Regression Testing', :visual do
  def desired_caps
    Selenium::WebDriver::Remote::W3C::Capabilities.new(browser_name: 'chrome',
                                                       browser_version: '80',
                                                       platform_name: 'MacOS 10.13',
                                                       "sauce:options": {name: @test_name,
                                                                         build: "Ruby-Visual-#{Time.now.to_i}",
                                                                         username: ENV['SAUCE_USERNAME'],
                                                                         accessKey: ENV['SAUCE_ACCESS_KEY']},
                                                       "sauce:visual": {apiKey: ENV['SCREENER_API_KEY'],
                                                                        projectName: 'visual-e2e-test',
                                                                        viewportSize: '1280x1024'})
  end

  it 'uses helper file to take snapshot' do
    @driver.navigate.to('https://screener.io')
    visual_snapshot 'Home'
  end
end
