Then 'I should see the div' do
  page = TestPage2.new @browser
  page.wait_until { page.div.displayed? }
end
