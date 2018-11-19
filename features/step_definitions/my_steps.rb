Given(/^I am on the Product Page$/) do
  @driver.get 'http://www.saucedemo.com/inventory.html'
end

When(/^I add (.*) items$/) do |number|
  number.to_i.times { @driver.find_element(class: 'add-to-cart-button').click }
end

Then(/^I should see (.*) items? in the cart$/) do |number|
  expect(@driver.find_element(class: 'shopping_cart_badge').text).to eq number
  @driver.get "https://www.saucedemo.com/cart.html"
  expect(@driver.find_elements(class: 'inventory_item_name').size).to eq number.to_i
end

Given(/^I am on the Login Page$/) do
  @driver.get 'http://www.saucedemo.com'
end

When(/^I log in with valid credentials$/) do
  @driver.find_element(css: "[data-test=username]").send_keys 'standard_user'
  @driver.find_element(css: "[data-test=password]").send_keys 'secret_sauce'
  @driver.find_element(css: "[type=submit]").click
end

Then(/^I should be logged in$/) do
  expect(@driver.current_url).to eq 'https://www.saucedemo.com/inventory.html'
end

When(/^I log in with invalid credentials$/) do
  @driver.find_element(css: "[data-test='username']").send_keys 'locked_out_user'
  @driver.find_element(css: "[data-test='password']").send_keys 'secret_sauce'
  @driver.find_element(css: "[type='submit']").click
end

Then(/^I should see an error$/) do
  expect(@driver.find_elements(class: 'error-button').size).to be > 0
end

And(/^I have (\d+) items in the Cart$/) do |number|
  number.to_i.times { @driver.find_element(class: 'add-to-cart-button').click }
end

When(/^I remove (\d+) item$/) do |number|
  number.times { @driver.find_element(class: 'remove-from-cart-button').click }
end
