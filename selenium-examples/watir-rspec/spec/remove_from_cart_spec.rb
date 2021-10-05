# frozen_string_literal: true

require 'spec_helper'

describe 'Cart' do

  before { @browser.goto 'www.saucedemo.com/v1/inventory.html' }

  it 'removes one' do
    @browser.button(class: 'btn_primary').click
    @browser.button(class: 'btn_primary').click

    @browser.button(class: 'btn_secondary').click
    expect(@browser.span(class: 'shopping_cart_badge').text).to eq '1'

    @browser.goto 'https://www.saucedemo.com/v1/cart.html'
    expect(@browser.divs(class: 'inventory_item_name').size).to eq 1
  end
end
