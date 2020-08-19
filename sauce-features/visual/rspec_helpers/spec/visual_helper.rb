# frozen_string_literal: true

require 'selenium-webdriver'

RSpec.shared_context 'with visual testing', shared_context: :metadata do
  # Setup and tear down the driver around each example
  before do |example|
    example_description = example.metadata[:visual] if example.metadata[:visual].instance_of? String
    @test_name = example_description || example.metadata[:example_group][:full_description]

    endpoint = 'https://hub.screener.io/wd/hub'
    @driver = Selenium::WebDriver.for :remote, url: endpoint, desired_capabilities: desired_caps
    @driver.execute_script '/*@visual.init*/', @test_name
  end

  after do
    if @driver
      visual_result = @driver.execute_script '/*@visual.end*/'
      @driver.quit

      msg = "expected no visual comparison failures, got #{visual_result['totals']}"
      expect(visual_result['passed']).to be_truthy, msg
    end
  end

  # Validate that all environment variables are set so we can access Screener
  before(:suite) do
    missing_creds = %w[SAUCE_USERNAME SAUCE_ACCESS_KEY SCREENER_API_KEY] - ENV.keys

    raise "Please set the #{missing_creds[0]} environment variable." if missing_creds.length == 1

    if missing_creds.length > 1
      raise 'Missing multiple environment variables; Please set the following before continuing: ' \
            "#{missing_creds.join ', '}"
    end

    @username = ENV['SAUCE_USERNAME']
    @access_key = ENV['SAUCE_ACCESS_KEY']
    @screener_key = ENV['SCREENER_API_KEY']
  end

  def visual_snapshot(snapshot_name)
    raise "Can't call #visual_snapshot outside of a visual testing example" unless @driver

    @driver.execute_script '/*@visual.snapshot*/', snapshot_name
  end
end

RSpec.configure do |rspec|
  rspec.include_context 'visual testing', :visual
end
