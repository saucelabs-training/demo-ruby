require "spec_helper"

describe "Guinea Pig Link" do
  it "Verify Link opens page with correct title" do
    visit "https://saucelabs-sample-test-frameworks.github.io/training-test-page/"
    click_link 'i_am_a_link'

    expect(page.title).not_to eq "I am a page title - Sauce Labs"
  end
end
