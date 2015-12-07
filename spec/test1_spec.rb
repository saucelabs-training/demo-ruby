require_relative "spec_helper"

describe "Google Search" do
  it "search text on google" do
  	@base_url = "https://www.google.co.in/"
    @browser.goto(@base_url + "/")
  end
end
