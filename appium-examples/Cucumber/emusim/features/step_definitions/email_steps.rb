Given /^I click on the email box$/ do
  email_input = @driver.find_element(:id, "fbemail")
  email_input.click()
end

When /^I enter my email address$/ do
  email_text = @driver.find_element(:id, "fbemail")
  email_text.send_keys("example@email.com")
end

Then /^I click the submit button$/ do
  submit_button = @driver.find_element(:id, "submit")
  submit_button.click()
end