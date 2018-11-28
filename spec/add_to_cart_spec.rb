require "spec_helper"

describe "Cart" do
  before { visit 'http://www.saucedemo.com/inventory.html'}

  it "adds one" do
    first('.add-to-cart-button').click

    expect(page).to have_css('.shopping_cart_badge', exact_text: '1')
    visit 'https://www.saucedemo.com/cart.html'
    expect(page).to have_css('.inventory_item_name', count: 1)
  end

  it "adds two" do
    first('.add-to-cart-button').click
    first('.add-to-cart-button').click

    expect(page).to have_css('.shopping_cart_badge', exact_text: '2')
    visit 'https://www.saucedemo.com/cart.html'
    expect(page).to have_css('.inventory_item_name', count: 2)
  end
end
