Given(/^I am on the Product Page$/) do
  visit 'http://www.saucedemo.com/inventory.html'
end

When(/^I add (.*) items$/) do |number|
  number.to_i.times { first('.add-to-cart-button').click }
end

Then(/^I should see (.*) items? in the cart$/) do |number|
  expect(first('.shopping_cart_badge').text).to eq number
  visit 'https://www.saucedemo.com/cart.html'
  expect(all('.inventory_item_name').size).to eq number.to_i
end

Given(/^I am on the Login Page$/) do
  visit 'http://www.saucedemo.com'
end

When(/^I log in with (valid|invalid) credentials$/) do |valid|
  username = valid == 'valid' ? 'standard_user' : 'locked_out_user'

  first('[data-test=username]').send_keys username
  first('[data-test=password]').send_keys 'secret_sauce'
  first('[type=submit]').click
end

Then(/^I should be logged in$/) do
  expect(current_url).to eq 'https://www.saucedemo.com/inventory.html'
end

Then(/^I should see an error$/) do
  expect(first('.error-button')).to_not be_nil
end

And(/^I have (\d+) items in the Cart$/) do |number|
  number.to_i.times { first('.add-to-cart-button').click }
end

When(/^I remove (\d+) item$/) do |number|
  number.times { first('.remove-from-cart-button').click }
end
