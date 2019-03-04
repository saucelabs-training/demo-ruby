# frozen_string_literal: true

#
# This is an example of Imperative Test code to keep things simple
# Your tests should be written declaritively
# This means adding abstractions for Page Objects and Data Objects that will do all of the work.
#
require 'spec_helper'

describe 'Cart' do
  before { @driver.get 'https://www.saucedemo.com/inventory.html' }

  it 'removes one' do
    @driver.find_element(class: 'add-to-cart-button').click
    @driver.find_element(class: 'add-to-cart-button').click

    @driver.find_element(class: 'remove-from-cart-button').click
    expect(@driver.find_element(class: 'shopping_cart_badge').text).to eq '1'

    @driver.get 'http://www.saucedemo.com/cart.html'
    expect(@driver.find_elements(class: 'inventory_item_name').size).to eq 1
  end
end
