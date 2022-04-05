require_relative 'spec_helper'

describe 'Catalog Page' do

  let(:wait) { Selenium::WebDriver::Wait.new }

  context 'when Android', platform: :android do
    it 'can add backpack' do
      backpack = wait.until { @driver.find_element(xpath: "//android.widget.TextView[contains(@text,'Backpack')]") }
      backpack.click

      expect {
        wait.until { @driver.find_element(xpath: '//*[@content-desc="product screen"]') }
      }.not_to raise_exception
    end
  end
end
