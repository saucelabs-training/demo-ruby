require 'sauce_whisk'

module SauceHelpers
  def initialize_browser(name)
    opt = {name: name,
                    build: build_name}

    YAML.safe_load(IO.read('spec/support/platforms.yml'))[platform].each do |key, value|
      opt[key] = value
    end

    opt[:url] = "https://ondemand.saucelabs.com:443/wd/hub"
    opt[:username] = ENV['SAUCE_USERNAME']
    opt[:accessKey] = ENV['SAUCE_ACCESS_KEY']

    @browser = Watir::Browser.new opt.delete('browser_name'), opt
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
    "Unknown Build - #{Time.now.to_i}"
  end
end
