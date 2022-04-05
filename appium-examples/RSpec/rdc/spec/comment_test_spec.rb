require_relative 'spec_helper'

describe 'Catalog Page' do

  let(:wait) { Selenium::WebDriver::Wait.new }

  context 'when Android', android: true do
    it 'can add backpack' do
      backpack = wait.until { @driver.find_element(xpath: "//android.widget.TextView[contains(@text,'Backpack')]") }
      backpack.click

      expect {
        wait.until { @driver.find_element(xpath: '//*[@content-desc="product screen"]') }
      }.not_to raise_exception
    end
  end

  context 'when iOS', ios: true do
    it 'can add backpack' do
      backpack = wait.until do
        @driver.find_element(class_chain: '**/XCUIElementTypeOther[`name == "store item" AND label CONTAINS "Backpack"`]')
      end
      backpack.click

      expect {
        wait.until { @driver.find_element(id: 'product screen') }
      }.not_to raise_exception
    end
  end
end
