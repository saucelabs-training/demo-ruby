Given /^I click on the iOS comment box$/ do
  commentInput = @driver.find_element(:id, "comments")
  commentInput.click()
end

When /^I enter an iOS comment$/ do
  commentText = @driver.find_element(:id, "comments")
  commentText.send_keys("My Exceptionally Eloquent Comment")
end

Then /^I click the iOS send button$/ do
  submitButton = @driver.find_element(:id, "submit")
  submitButton.click()
end