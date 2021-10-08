# frozen_string_literal: true

require "spec_helper"

describe 'Firefox Addons' do
  it "Installs and Uninstalls", browser: :firefox do
    addon_id = @driver.install_addon("spec/resources/ninja_saucebot-1.0-an+fx.xpi")

    @driver.get "https://www.saucedemo.com"
    expect(@driver.find_elements(class: 'bot_column2')).not_to be_empty

    @driver.uninstall_addon(addon_id)

    @driver.navigate.refresh
    expect(@driver.find_elements(class: 'bot_column2')).to be_empty
  end
end
