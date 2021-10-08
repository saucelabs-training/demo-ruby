# frozen_string_literal: true

require "spec_helper"

describe 'Relative Locators' do
  it "can locate" do
    @driver.get("https://www.diemol.com/selenium-4-demo/relative-locators-demo.html")

    element = @driver.find_element(relative: {tag_name: 'li', left: {id: 'berlin'}, below: {id: 'warsaw'}})

    @driver.execute_script("arguments[0].style.filter='blur(8px)'", element)

    expect(element.attribute('id')).to eq 'london'
  end
end
