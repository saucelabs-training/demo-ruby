require "rspec/expectations"
require "watir-webdriver"
require "rspec"
require "sauce_whisk"

RSpec.configure do | config |

  config.before(:each) do | x |
    capabilities_config = {
      :version => "#{ENV['version']}",
      :browserName => "#{ENV['browserName']}",
      :platform => "#{ENV['platform']}",
      :name => x.full_description
    }

    url = "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:80/wd/hub".strip

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 180
    @browser = Watir::Browser.new(:remote, :url => url, :desired_capabilities => capabilities_config, :http_client => client)
  end

  config.after(:each) do | example |
    sessionid = @browser.driver.send(:bridge).session_id
    @browser.quit


    if example.exception
      SauceWhisk::Jobs.fail_job sessionid
    else
      SauceWhisk::Jobs.pass_job sessionid
    end
  end

end
