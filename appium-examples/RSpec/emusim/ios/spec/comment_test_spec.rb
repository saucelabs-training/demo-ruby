require_relative "spec_helper"

describe "Guinea Pig" do
  it "enter a comment" do
    app = GuineaPigAppPage.new @driver
    app.textInput.send_keys("My Exceptionally Eloquent Comment")
    expect(app.textInput.text == "My Exceptionally Eloquent Comment")
  end

  it "should enter an email address" do
    app = GuineaPigAppPage.new @driver
    app.emailTextInput.send_keys("example@email.com")
    expect(app.emailTextInput.text == "example@email.com")
  end
end