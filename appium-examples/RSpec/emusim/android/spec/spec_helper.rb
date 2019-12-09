require "rspec/expectations"
require "appium_lib"
require "rspec"
require "sauce_whisk"
require "selenium-webdriver"
require "require_all"

begin
  require_all "#{File.join(File.expand_path(File.dirname(__FILE__)), '..', 'pages')}"
rescue
  puts "no page objects found"
end


RSpec.configure do | config |

  config.before(:each) do | example |

    caps = {
        caps: {
            platformVersion: "#{ENV['platformVersion']}",
            deviceName: "#{ENV['deviceName']}",
            platformName: "#{ENV['platformName']}",
            app: "#{ENV['app']}",
            deviceOrientation: 'portrait',
            name: example.full_description,
            appiumVersion: '1.9.1',
            browserName: '',
            build: 'Appium RSpec Examples'
        }
    }

    #caps.merge!({deviceType: "ENV['deviceType']"}) if ENV['deviceType'] != ''

    @driver = Appium::Driver.new(caps)
    @driver.start_driver

  end

  config.after(:each) do | example |
    sessionid = @driver.session_id
    @driver.driver_quit
    puts "SauceOnDemandSessionID=#{sessionid} job-name=#{example.full_description}"


    if example.exception
      SauceWhisk::Jobs.fail_job sessionid
    else
      SauceWhisk::Jobs.pass_job sessionid
    end
  end

  #Explicit wait definition
  def wait_for
    Selenium::WebDriver::Wait.new(:timeout => 10).until { yield }
  end


end