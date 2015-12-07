Then 'I should see the free trial sign-up form' do
  page = FreeTrialPage.new @browser
  page.wait_until { page.form.displayed? }
end
