require_relative 'spec_helper'

describe 'Catalog Page' do

  let(:wait) { Selenium::WebDriver::Wait.new }

  context 'when mobile web', platform: :web do
    it 'can add backpack' do
      @driver.get 'https://www.saucedemo.com'
      @driver.manage.add_cookie(name: 'session-username', value: 'standard_user')
      @driver.get 'https://www.saucedemo.com/inventory.html'

      item = wait.until do
        @driver.find_element(css: '.inventory_item_name')
      end
      item.click

      expect {
        wait.until { @driver.find_element(css: '.inventory_item_container') }
      }.not_to raise_exception
    end
  end
end
