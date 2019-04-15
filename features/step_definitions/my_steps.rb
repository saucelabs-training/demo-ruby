Given(/^I am on the Product Page$/) do
  @browser.goto 'www.saucedemo.com/inventory.html'
end

When(/^I add (.*) items$/) do |number|
  number.to_i.times { @browser.button(class: 'btn_primary').click }
end

Then(/^I should see (.*) items? in the cart$/) do |number|
  expect(@browser.span(class: 'shopping_cart_badge').text).to eq number
  @browser.goto "https://www.saucedemo.com/cart.html"
  expect(@browser.divs(class: 'inventory_item_name').size).to eq number.to_i
end

Given(/^I am on the Login Page$/) do
  @browser.goto 'www.saucedemo.com'
end

When(/^I log in with valid credentials$/) do
  @browser.text_field(data_test: 'username').set 'standard_user'
  @browser.text_field(data_test: 'password').set 'secret_sauce'
  @browser.button(type: 'submit').click
end

Then(/^I should be logged in$/) do
  expect(@browser.url).to eq 'https://www.saucedemo.com/inventory.html'
end

When(/^I log in with invalid credentials$/) do
  @browser.text_field(data_test: 'username').set 'locked_out_user'
  @browser.text_field(data_test: 'password').set 'secret_sauce'
  @browser.button(type: 'submit').click
end

Then(/^I should see an error$/) do
  expect(@browser.button(class: 'error-button')).to exist
end

And(/^I have (\d+) items in the Cart$/) do |number|
  number.times { @browser.button(class: 'btn_primary').click }
end

When(/^I remove (\d+) item$/) do |number|
  number.times { @browser.button(class: 'btn_secondary').click }
end
