class FreeTrialPage
  include PageObject

  def form
    @browser.find_element(:id => 'trial-signup-form')
  end

end
