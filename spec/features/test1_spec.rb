require "spec_helper"

describe "Wikipedia's Ramen Page", :sauce => true do
  it "Should mention the inventor of instant Ramen" do
    visit "http://en.wikipedia.org/"
    fill_in 'search', :with => "Ramen"
    click_button "searchButton"

    heading = find '#firstHeading'
    expect( heading ).to have_content "Ramen"
  end
end
