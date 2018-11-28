require "watir"
require 'sauce_whisk'

RSpec.configure do |config|
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

  config.before(:each) do |test|
    opt = {name: test.full_description,
           build: build_name,
           url: "https://ondemand.saucelabs.com:443/wd/hub",
           username: ENV['SAUCE_USERNAME'],
           accessKey: ENV['SAUCE_ACCESS_KEY']}

    opt.merge! platform

    @browser = Watir::Browser.new opt.delete('browser_name'), opt
  end

  config.after(:each) do |example|
    SauceWhisk::Jobs.change_status(@browser.wd.session_id, !example.exception)

    @browser.quit
  end
end
