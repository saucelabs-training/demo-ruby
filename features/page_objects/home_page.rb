class HomePage
  def initialize(browser)
    @browser = browser
  end

  def visit
    @browser.navigate.to "https://saucelabs-sample-test-frameworks.github.io/training-test-page/"
  end

  def title
    @browser.title
  end

  def follow_link
  	@browser.find_element(id: 'i_am_a_link').click
  end

  def comment=(text)
  	@browser.find_element(id: 'comments').send_keys(text)
    @browser.find_element(id: 'submit').click
  end

  def comment
    @browser.find_element(id: 'your_comments').text[/^Your comments: (.*)/, 1]
  end
end
