require 'sauce_whisk'

module SauceHelpers
  def initialize_browser(name)
    opt = {name: name,
           build: build_name,
           username: ENV['SAUCE_USERNAME'],
           accessKey: ENV['SAUCE_ACCESS_KEY']}

    opt.merge! YAML.safe_load(IO.read('spec/support/platforms.yml'))[platform]

    caps = Selenium::WebDriver::Remote::Capabilities.send(opt.delete('browser_name').to_sym, opt)
    url = "https://ondemand.saucelabs.com:443/wd/hub"
    @driver = Selenium::WebDriver.for(:remote, url: url, desired_capabilities: caps)

  end

  def submit_results(session_id, result)
    SauceWhisk::Jobs.change_status(session_id, result)
  end

  def platform
    ENV['PLATFORM'] || 'mac_sierra_chrome'
  end

  def build_name
    %w[SAUCE_BAMBOO_BUILDNUMBER CIRCLE_BUILD_NUM BUILD_TAG TRAVIS_BUILD_NUMBER"].each do |var|
      return ENV[var] if ENV.key?(var)
    end
    #"Unknown Build - #{Time.now.to_i}"
    "Ruby RSpec Selenium 1"

  end
end
