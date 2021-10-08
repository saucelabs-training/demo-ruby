# frozen_string_literal: true

require "spec_helper"

describe 'View Firefox' do
  it "Print Page", browser: :firefox do
    @driver.get('https://www.saucedemo.com/v1/inventory.html')
    @driver.save_print_page('spec/resources/firefoxPrintPage.pdf')
  end

  it "Takes Screenshot", browser: :firefox do
    @driver.get('https://www.saucedemo.com/v1/inventory.html')
    @driver.save_screenshot('spec/resources/firefoxScreenshot.png')
  end

  it "Takes Full Page Screenshot", browser: :firefox do
    @driver.get('https://www.saucedemo.com/v1/inventory.html')
    @driver.save_screenshot('spec/resources/firefoxFullPageScreenshot.png', full_page: true)
  end
end
