Given 'I am on the Sauce Labs homepage' do
  @browser.get 'http://www.saucelabs.com/'
end

Then /the title of the page should be/ do |text|
  expect(@browser.title).to be == text
end

And 'I click on the free trial button' do
  page = HomePage.new @browser
  page.freeTrialButton.click
end