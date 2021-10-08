# frozen_string_literal: true

require "spec_helper"

describe 'New Window' do
  it "Opens New Window" do
    @driver.switch_to.new_window(:window)
    @driver.manage.window.position = Selenium::WebDriver::Point.new(100, 400)
    expect(@driver.window_handles.size).to eq 2
  end

  it "Opens New Tab" do
    @driver.switch_to.new_window(:tab)
    expect(@driver.window_handles.size).to eq 2
  end
end
