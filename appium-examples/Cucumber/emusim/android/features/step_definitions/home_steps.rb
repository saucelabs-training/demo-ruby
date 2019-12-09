Given /^I click on the Android comment box$/ do
  commentInput = @driver.find_element(:id, "comments")
  commentInput.click()
end

When /^I enter an Android comment$/ do
  commentText = @driver.find_element(:id, "comments")
  commentText.send_keys("My Exceptionally Eloquent Comment")
end

Then /^I click the Android send button$/ do
  submitButton = @driver.find_element(:id, "submit")
  submitButton.click()
end