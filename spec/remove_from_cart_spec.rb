require "spec_helper"

describe "Cart" do
  before { visit 'http://www.saucedemo.com/inventory.html' }

  it "removes one" do
    first('.add-to-cart-button').click
    first('.add-to-cart-button').click
    first('.remove-from-cart-button').click

    expect(first('.shopping_cart_badge').text).to eq '1'
    visit 'https://www.saucedemo.com/cart.html'

    expect(all('.inventory_item_name').size).to eq 1
  end
end
