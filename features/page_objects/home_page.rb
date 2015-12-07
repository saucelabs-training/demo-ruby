class HomePage
  include PageObject

  def freeTrialButton
  	@browser.find_element(:css => '.button.red[href*=trial]')
  end

end