# frozen_string_literal: true

require 'watir'
require 'simple_sauce'

RSpec.configure do |config|
  config.before do |example|
    opts = platform.merge(name: example.full_description,
                          build: build_name)
    sauce_options = SimpleSauce::Options.new(opts)

    @session = SimpleSauce::Session.new(sauce_options)

    @browser = Watir::Browser.new @session.start
  end

  config.after do |example|
    @session.stop(!example.exception)
  end

  #
  # Note that having this as a conditional in the test code is less ideal
  # It is better for static data to be pulled from a serialized file like a yaml
  #
  def platform
    ENV['PLATFORM'] ||= 'mac_sierra_chrome'

    case ENV['PLATFORM']
    when 'windows_10_edge'
      {platform_name: 'Windows 10',
       browser_name: 'MicrosoftEdge',
       browser_version: '18.17763'}
    when 'windows_8_ie'
      {platform_name: 'Windows 8.1',
       browser_name: 'internet explorer',
       browser_version: '11.0'}
    when 'mac_sierra_chrome'
      {platform_name: 'macOS 10.12',
       browser_name: 'chrome',
       browser_version: '75.0'}
    when 'mac_mojave_safari'
      {platform_name: 'macOS 10.14',
       browser_name: 'safari',
       browser_version: '12.0'}
    when 'windows_7_ff'
      {platform_name: 'Windows 7',
       browser_name: 'firefox',
       browser_version: '60.0'}
    when 'headless'
      ENV['SAUCE_DATA_CENTER'] = 'US_EAST'
      {platform_name: 'Linux',
       browser_name: 'chrome'}
    end
  end

  #
  # Give a good build name when running locally
  #
  def build_name
    return if ENV['TRAVIS_REPO_SLUG']

    time = ENV['SAUCE_START_TIME'] || Time.now.to_i.to_s
    "RSpec Example: Local-#{time}"
  end
end
