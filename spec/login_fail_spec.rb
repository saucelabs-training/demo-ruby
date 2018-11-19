require "spec_helper"

describe "Authentication" do
  before { visit 'http://www.saucedemo.com' }

  it "fails" do
    first('[data-test=username]').send_keys 'locked_out_user'
    first('[data-test=password]').send_keys 'secret_sauce'

    first('[type=submit]').click

    expect(first('.error-button')).to_not be_nil
  end
end
