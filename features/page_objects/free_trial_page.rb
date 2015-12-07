class FreeTrialPage
  include PageObject

  def form
    @browser.element(:id => 'trial-signup-form')
  end

end
