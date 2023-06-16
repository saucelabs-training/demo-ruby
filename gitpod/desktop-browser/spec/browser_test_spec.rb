require 'selenium-webdriver'
require 'rspec'
require 'spec_helper'

# see ./sepc_helper.rb for session creation and destruction
describe 'Gitpod' do
  it 'basic browser test' do
    @driver.get('https://www.example.com')

    # Perform your test actions here

    # Add your assertions here
    expect(@driver.title).to include('')
  end
end
