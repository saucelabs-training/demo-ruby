# frozen_string_literal: true

require 'spec_helper'

describe 'Cart' do
  before { @browser.goto 'www.saucedemo.com/inventory.html' }

  it 'adds one' do
    @browser.button(class: 'btn_primary').click

    expect(@browser.span(class: 'shopping_cart_badge').text).to eq '1'
    @browser.goto 'https://www.saucedemo.com/cart.html'
    expect(@browser.divs(class: 'inventory_item_name').size).to eq 1
  end

  it 'adds two' do
    @browser.button(class: 'btn_primary').click
    @browser.button(class: 'btn_primary').click

    expect(@browser.span(class: 'shopping_cart_badge').text).to eq '2'
    @browser.goto 'https://www.saucedemo.com/cart.html'
    expect(@browser.divs(class: 'inventory_item_name').size).to eq 2
  end
end
