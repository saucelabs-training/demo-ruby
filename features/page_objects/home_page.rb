class HomePage
  def initialize(browser)
    @browser = browser
  end

  def link
  	@browser.find_element(:css => "[id='i am a link']")
  end

  def email_text_box
  	@browser.find_element(:id => 'fbemail')
  end
end