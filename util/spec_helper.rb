require "rspec/expectations"
require "selenium-webdriver"
require "rspec"
require "sauce_whisk"

def setup_sauce_env()
  if ENV['SAUCE_USERNAME'] == nil or ENV['SAUCE_ACCESS_KEY'] == nil
    abort("No Sauce Labs credentials are set!")
  end
end

RSpec.configure do | config |
  config.before(:all) do
    setup_sauce_env()
  end

  config.before(:each) do | test |
    capabilities_config = {
      :version => "#{ENV['version']}",
      :browserName => "#{ENV['browserName']}",
      :platform => "#{ENV['platform']}",
      :name => test.full_description
    }
    #If there's a build tag set it.
    if ENV['BUILD_TAG'] != nil
      capabilities_config['build'] = ENV['BUILD_TAG']
    end
    if ENV['TUNNEL_IDENTIFIER'] != nil
      capabilities_config['tunnel-identifier'] = ENV['TUNNEL_IDENTIFIER']
    end
    url = "https://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:443/wd/hub".strip
    @browser = Selenium::WebDriver.for(:remote, :url => url, :desired_capabilities => capabilities_config)
  end

  config.after(:each) do | test |
    sessionid = @browser.session_id
    puts("SauceOnDemandSessionID=#{sessionid} job-name=#{test.full_description}")
    @browser.quit
    if test.exception
      SauceWhisk::Jobs.fail_job sessionid
    else
      SauceWhisk::Jobs.pass_job sessionid
    end
  end

end
