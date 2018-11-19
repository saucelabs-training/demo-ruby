require "spec_helper"

describe "Cart" do
  before { visit 'http://www.saucedemo.com/inventory.html'}

  it "adds one" do
    first('.add-to-cart-button').click

    expect(first('.shopping_cart_badge').text).to eq '1'
    visit 'https://www.saucedemo.com/cart.html'
    expect(all('.inventory_item_name').size).to eq 1
  end

  it "adds two" do
    first('.add-to-cart-button').click
    first('.add-to-cart-button').click

    expect(first('.shopping_cart_badge').text).to eq '2'
    visit 'https://www.saucedemo.com/cart.html'
    expect(all('.inventory_item_name').size).to eq 2
  end
end
