Given /^I click on the comment box$/ do
  comment_input = @driver.find_element(:id, "comments")
  comment_input.click()
end

When /^I enter a comment$/ do
  comment_text = @driver.find_element(:id, "comments")
  comment_text.send_keys("My Exceptionally Eloquent Comment")
end

Then /^I click the send button$/ do
  submit_button = @driver.find_element(:id, "submit")
  submit_button.click()
end