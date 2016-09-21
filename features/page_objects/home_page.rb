class HomePage
  include PageObject

  def link
  	@browser.find_element(:id => 'i am a link')
  end

  def email_text_box
  	@browser.find_element(:id => 'fbemail')
  end

end