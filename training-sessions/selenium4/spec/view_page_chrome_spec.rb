# frozen_string_literal: true

require "spec_helper"

describe 'View Chrome' do
  it "Print Page", headless: true do
    @driver.get('https://www.saucedemo.com/v1/inventory.html')
    @driver.save_print_page('spec/resources/chromePrintPage.pdf')
  end

  it "Takes Screenshot" do
    @driver.get('https://www.saucedemo.com/v1/inventory.html')
    @driver.save_screenshot('spec/resources/chromeScreenshot.png')
  end
end
