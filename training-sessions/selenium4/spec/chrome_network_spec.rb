# frozen_string_literal: true

require "spec_helper"

describe 'Network Conditions' do
  it "sets offline" do
    # Selenium 4 RC 3 does not support partial conditions, fixed for next release
    @driver.network_conditions = {offline: true, latency: 1, throughput: 10000}

    expect {
      @driver.get('https://www.saucedemo.com')
    }.to raise_exception(Selenium::WebDriver::Error::UnknownError, /unknown error: net::ERR_INTERNET_DISCONNECTED/)
  end
end
