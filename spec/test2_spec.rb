require_relative "spec_helper"

describe "Google Search 2" do
  it "search text on google 2" do
  	@base_url = "https://www.google.co.in/"
    @browser.goto(@base_url + "/")
  end
end
