Given 'I am on the Guinea Pig homepage' do
  @home_page = HomePage.new(@browser)
  @home_page.visit
end

Then /I should be on another page/ do
  another_page = AnotherPage.new(@browser)
  expect(another_page.on_page?).to eq true
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
