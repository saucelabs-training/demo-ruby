# frozen_string_literal: true

require "spec_helper"

describe 'Timeouts' do
  it "can get from driver" do
    @driver.manage.timeouts.implicit_wait = 1

    expect(@driver.manage.timeouts.implicit_wait).to eq 1
    expect(@driver.manage.timeouts.page_load).to eq 300
    expect(@driver.manage.timeouts.script).to eq 30
  end
end
