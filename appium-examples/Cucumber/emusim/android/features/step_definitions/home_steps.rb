Given /^I click on the add contact button$/ do
  addContactButton = @driver.find_element(:class_name, "android.widget.Button")
  addContactButton.click()
end

When /^I enter a name and email$/ do
  textFieldsList = @driver.find_elements(:class_name, "android.widget.EditText")
  textFieldsList[0].send_keys("Some Name")
  textFieldsList[2].send_keys("Some@example.com")
end

Then /^I click the Save button$/ do
  @driver.find_element(:class_name, "android.widget.Button").click
end