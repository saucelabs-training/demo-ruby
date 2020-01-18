require 'spec_helper'

describe 'Passing Test' do
  it 'logs in successfully' do

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
