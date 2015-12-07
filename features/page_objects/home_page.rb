class HomePage
  include PageObject

  def freeTrialButton
  	@browser.element(:css => '.button.red[href*=trial]')
  end

end