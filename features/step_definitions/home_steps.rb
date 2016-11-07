Given 'I am on the Guinea Pig homepage' do
  @home_page = HomePage.new(@browser)
  @home_page.visit
end

Then /the title of the page should be/ do |text|
  expect(@home_page.title).to eq text
end

And 'I click on the link' do
  @home_page.follow_link
end

When /^I submit a comment$/ do
  @comment = "This is a comment"
	@home_page.comment = @comment
end

Then /^I should see that comment displayed$/ do
	expect(@home_page.comment).to eq @comment
end
