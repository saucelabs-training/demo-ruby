Given 'I am on the Guinea Pig homepage' do
  @browser.get 'http://saucelabs.github.io/training-test-page/'
end

Then /the title of the page should be/ do |text|
  expect(@browser.title).to be == text
end

And 'I click on the link' do
  page = HomePage.new @browser
  page.link.click
end

When /^I type "(.*)" in the email text field$/ do | text |
	page = HomePage.new @browser
	page.email_text_box.send_keys text
end

Then /^I should see "(.*)" in the email text field$/ do | text |
	page = HomePage.new @browser
	actual = page.email_text_box.attribute('value')
	expect(actual).to be == text
end
