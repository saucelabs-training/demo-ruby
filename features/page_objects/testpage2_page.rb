class TestPage2
  include PageObject

  def div
    @browser.find_element(:id => 'i_am_an_id')
  end

end
