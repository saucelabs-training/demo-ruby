# frozen_string_literal: true

require 'spec_helper'

describe 'Cart' do
  before { visit 'https://www.saucedemo.com/v1/inventory.html' }

  it 'removes one' do
    first('.btn_primary').click
    first('.btn_primary').click
    first('.btn_secondary').click

    expect(page).to have_css('.shopping_cart_badge', exact_text: '1')
    visit 'https://www.saucedemo.com/v1/cart.html'

    expect(page).to have_css('.inventory_item_name', count: 1)
  end
end
