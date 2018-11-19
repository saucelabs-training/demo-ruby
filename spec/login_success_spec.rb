require "spec_helper"

describe "Authentication" do
  before { visit 'http://www.saucedemo.com' }

  it "successful" do

    first('[data-test=username]').send_keys 'standard_user'
    first('[data-test=password]').send_keys 'secret_sauce'

    first('[type=submit]').click

    expect(current_url).to eq 'https://www.saucedemo.com/inventory.html'
  end
end
