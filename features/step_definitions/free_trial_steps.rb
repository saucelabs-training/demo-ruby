Then 'I should see the free trial sign-up form' do
  page = FreeTrialPage.new @browser
  page.form.wait_until_present
end
