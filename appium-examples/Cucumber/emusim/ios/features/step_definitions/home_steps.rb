Given /^I enter "(.*)" into text field with accessibility id "(.*)"$/ do | text, accessibility_id |
  @driver.find_element(:accessibility_id, accessibility_id).send_keys text
end

Given /^I enter "(.*)" into text field with class name "(.*)"$/ do | text, class_name |
  @driver.find_elements(:class_name, class_name)[1].send_keys text
end

When /^I click the button with the accessibility id "(.*)"$/ do | accessibility_id |
  @driver.find_element(:accessibility_id, accessibility_id).click()
end

Then /^the sum should equal "(.*)"$/ do | text |
  sum = @driver.find_element(:class_name, "UIAStaticText").text();
  expect(sum).to eq(text)

end