require "spec_helper"

describe "Guinea Pig Comments" do
  it "Verify comments text" do
    visit "https://saucelabs-sample-test-frameworks.github.io/training-test-page/"

    text = "This is a comment"
    fill_in 'comments', with: text
    click_button "submit"

    element = find '#your_comments'

    comment = element.text[/^Your comments: (.*)/, 1]

    expect(comment).to eq text
  end
end
