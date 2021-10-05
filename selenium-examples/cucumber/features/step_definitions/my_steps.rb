# frozen_string_literal: true

Given(/^I am on the Product Page$/) do
  @driver.get 'http://www.saucedemo.com/v1/inventory.html'
end

When(/^I add (.*) items$/) do |number|
  number.to_i.times { @driver.find_element(class: 'btn_primary').click }
end

Then(/^I should see (.*) items? in the cart$/) do |number|
  expect(@driver.find_element(class: 'shopping_cart_badge').text).to eq number
  @driver.get 'https://www.saucedemo.com/v1/cart.html'
  expect(@driver.find_elements(class: 'inventory_item_name').size).to eq number.to_i
end

Given(/^I am on the Login Page$/) do
  @driver.get 'http://www.saucedemo.com'
end

When(/^I log in with valid credentials$/) do
  @driver.find_element(css: '[data-test=username]').send_keys 'standard_user'
  @driver.find_element(css: '[data-test=password]').send_keys 'secret_sauce'
  @driver.find_element(css: '[type=submit]').click
  sleep 0.5 # this was added due to CI Runner latency. Don't do this normally, this is a bad practice.
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
  expect(@driver.find_elements(class: 'error-button').size).to be_positive
end

And(/^I have (\d+) items in the Cart$/) do |number|
  number.to_i.times { @driver.find_element(class: 'btn_primary').click }
end

When(/^I remove (\d+) item$/) do |number|
  number.to_i.times { @driver.find_element(class: 'btn_secondary').click }
end
