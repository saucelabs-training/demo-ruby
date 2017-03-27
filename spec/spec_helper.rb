require "sauce_whisk"
require "capybara/rspec"
require "capybara"
require "rspec"
require "json"

Capybara.default_max_wait_time = 10
Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers

  config.before(:each) do | scenario |
    Capybara.register_driver :selenium do | app|
      capabilities = {
        :version => ENV['version'],
        :browserName => ENV['browserName'],
        :platform => ENV['platform'],
        :name => scenario.full_description
      }
      url = "https://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:443/wd/hub".strip

      Capybara::Selenium::Driver.new(app,
                                     :browser => :remote, :url => url,
                                     :desired_capabilities => capabilities)
    end

    # Capybara.current_driver = :remote
    jobname = scenario.full_description
    Capybara.session_name = "#{jobname} - #{ENV['platform']} - " +
      "#{ENV['browserName']} - #{ENV['version']}"

    @driver = Capybara.current_session.driver

    # Output sessionId and jobname to std out for Sauce OnDemand Plugin to display embeded results
    @session_id = @driver.browser.session_id
    puts "SauceOnDemandSessionID=#{@session_id} job-name=#{jobname}"
  end

  config.after(:each) do | scenario |
    @driver.quit
    Capybara.use_default_driver
    if scenario.exception
      SauceWhisk::Jobs.fail_job @session_id
    else
      SauceWhisk::Jobs.pass_job @session_id
    end
  end
end
