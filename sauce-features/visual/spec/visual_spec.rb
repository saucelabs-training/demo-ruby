# frozen_string_literal: true

require 'spec_helper'

describe 'Visual Regression Testing' do
  it 'takes snapshot' do
    @driver.navigate.to('https://screener.io')
    @driver.execute_script('/*@visual.init*/', 'My Visual Test')
    @driver.execute_script('/*@visual.snapshot*/', 'Home')
  end
end
