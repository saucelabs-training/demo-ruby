begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'watir-webdriver'
require 'page-object'
require 'require_all'
require 'sauce_whisk'

begin
  require_all "#{File.join(File.expand_path(File.dirname(__FILE__)), '..', 'page_objects')}"
rescue
  puts "no page objects found"
end

@browser = nil

Before do | scenario |
  @version = ENV['version']
  @browserName = ENV['browserName']
  @platform = ENV['platform']

  capabilities_config = {
    :version => @version,
    :browserName => @browserName,
    :platform => @platform,
    :name => "#{scenario.feature.name} - #{scenario.name}"
  }

  url = "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:80/wd/hub".strip

  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 180
  @browser = Watir::Browser.new(:remote, :url => url, :desired_capabilities => capabilities_config, :http_client => client)
end

After do | scenario |
  sessionid = @browser.driver.send(:bridge).session_id
  jobname = "#{scenario.feature.name} - #{scenario.name}"

  puts "SauceOnDemandSessionID=#{sessionid} job-name=#{jobname}"

  @browser.close

  if scenario.passed?
    SauceWhisk::Jobs.pass_job sessionid
  else
    SauceWhisk::Jobs.fail_job sessionid
  end
end