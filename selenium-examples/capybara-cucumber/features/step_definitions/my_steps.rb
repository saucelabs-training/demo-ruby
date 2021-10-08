# frozen_string_literal: true

Given(/^I am on the Product Page$/) do
  visit 'https://www.saucedemo.com/v1/inventory.html'
end

When(/^I add (.*) items$/) do |number|
  number.to_i.times { first('.btn_primary').click }
end

Then(/^I should see (.*) items? in the cart$/) do |number|
  expect(page).to have_css('.shopping_cart_badge', exact_text: number)
  visit 'https://www.saucedemo.com/v1/cart.html'

  expect(page).to have_css('.inventory_item_name', count: number.to_i)
end

Given(/^I am on the Login Page$/) do
  visit 'https://www.saucedemo.com'
end

When(/^I log in with (valid|invalid) credentials$/) do |valid|
  username = valid == 'valid' ? 'standard_user' : 'locked_out_user'

  fill_in 'Username', with: username
  fill_in 'Password', with: 'secret_sauce'
  click_button('Login')
end

Then(/^I should be logged in$/) do
  expect(page).to have_current_path('https://www.saucedemo.com/inventory.html')
end

Then(/^I should see an error$/) do
  expect(page).to have_css('.error-button')
end

And(/^I have (\d+) items in the Cart$/) do |number|
  number.to_i.times { first('.btn_primary').click }
end

When(/^I remove (\d+) item$/) do |number|
  number.to_i.times { first('.btn_secondary').click }
end
