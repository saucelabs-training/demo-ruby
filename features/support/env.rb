require 'watir'
require 'rspec'
require 'sauce_whisk'

Before do |scenario|
  def platforms
    YAML.safe_load(IO.read('platforms.yml'))
  end

  def platform
    platforms[ENV['PLATFORM']] || platforms.first
  end

  opt = {name: "#{scenario.feature.name} - #{scenario.name}",
         build: build_name,
         url: "https://ondemand.saucelabs.com:443/wd/hub",
         username: ENV['SAUCE_USERNAME'],
         accessKey: ENV['SAUCE_ACCESS_KEY']}

  opt.merge! platform

  @browser = Watir::Browser.new opt.delete('browser_name'), opt
end

After do |scenario|
  SauceWhisk::Jobs.change_status(@browser.wd.session_id, scenario.passed?)

  @browser.quit
end
