class HomePage
  def initialize(browser)
    @browser = browser
  end

  def visit
    @browser.navigate.to "http://saucelabs.github.io/training-test-page/"
  end

  def title
    @browser.title
  end

  def follow_link
  	@browser.find_element(css: "[id='i am a link']").click
  end

  def comment=(text)
  	@browser.find_element(id: 'comments').send_keys(text)
    @browser.find_element(id: 'submit').click
  end

  def comment
    @browser.find_element(id: 'your_comments').text[/^Your comments: (.*)/, 1]
  end
end
