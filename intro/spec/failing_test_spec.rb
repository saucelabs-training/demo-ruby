require 'spec_helper'

describe 'Failing Test' do
  it 'does not log in' do

    # Navigate
    @driver.get("<URL>")

    # Fill out Form
    @driver.find_element("<USERNAME LOCATOR>").send_keys("<USER VALUE>")
    @driver.find_element("<PASSWORD LOCATOR>").send_keys("<PASSWORD VALUE>")
    @driver.find_element("<SUBMIT BUTTON LOCATOR>").click

    # Validate page is correct
    expect(@driver.current_url).to eq "<EXPECTED URL>"
  end
end
