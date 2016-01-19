require_relative "../util/spec_helper"

describe "Google Search 2" do
  it "search text on google 2" do
  	@base_url = "https://www.google.co.in/"
    @browser.get(@base_url + "/")
  end
end
