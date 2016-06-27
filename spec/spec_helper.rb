require "sauce_whisk"
require "capybara/rspec"
require "capybara"
require "rspec"
require "json"

Capybara.register_driver :selenium do | app|
  capabilities = {
    :version => ENV['version'],
    :browserName => ENV['browserName'],
    :platform => ENV['platform'],
  }

  url = "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:80/wd/hub".strip

  Capybara::Selenium::Driver.new(app,
                                 :browser => :remote, :url => url,
                                 :desired_capabilities => capabilities)
end

Capybara.default_max_wait_time = 10
Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers

  config.after(:each) do | scenario |
    jobname = scenario.full_description
    sessionid = ::Capybara.current_session.driver.browser.session_id
    ::Capybara.current_session.driver.quit

    # Output sessionId and jobname to std out for Sauce OnDemand Plugin to display embeded results
    puts "SauceOnDemandSessionID=#{sessionid} job-name=#{jobname}"

    job = SauceWhisk::Jobs.fetch sessionid
    job.name = jobname
    job.save

    if scenario.exception
      SauceWhisk::Jobs.fail_job sessionid
    else
      SauceWhisk::Jobs.pass_job sessionid
    end
  end
end
