Given /^I click on the email box$/ do
  emailInput = @driver.find_element(:id, "fbemail")
  emailInput.click()
end

When /^I enter my email address$/ do
  emailText = @driver.find_element(:id, "fbemail")
  emailText.send_keys("example@email.com")
end

Then /^I click the submit button$/ do
  submitButton = @driver.find_element(:id, "submit")
  submitButton.click()
end